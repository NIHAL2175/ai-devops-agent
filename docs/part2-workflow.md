# Part 2 — Understanding the Workflow

## Overview

Before writing any code or deployment configs, you need to understand how the entire system flows. This part traces the complete journey — from a developer writing code locally, all the way to deploying and monitoring applications in production.

```mermaid
flowchart LR
    A[👩‍💻 Developer] --> B[Local Docker]
    B --> C[Git Push]
    C --> D[GitHub Actions CI]
    D --> E[ECR Images]
    E --> F[ArgoCD GitOps]
    F --> G[EKS Cluster]
    G --> H[Prometheus + Grafana]
    H --> I[CloudWatch Logs]
```

---

## Stage 1: Local Development

Every change starts on a developer's machine. The full application stack runs locally using Docker Compose — no cloud account required.

```mermaid
flowchart TD
    Dev[Developer writes code] --> DC[docker-compose up]
    DC --> F[Frontend :3000]
    DC --> G[Gateway :3001]
    DC --> A[Auth :3002]
    DC --> P[Product Service :3003]
    DC --> OS[Order Service :3004]
    DC --> O[Orders :3005]
    DC --> U[User Service :3006]
    DC --> DB[(PostgreSQL :5432)]
    DC --> PR[Prometheus :9090]
    DC --> GR[Grafana :3007]

    G --> A
    G --> P
    G --> OS
    G --> O
    G --> U
    A --> DB
    P --> DB
    O --> DB
    U --> DB
```

Each service has its own `Dockerfile`. Docker Compose wires them together with a shared network, letting you test the full system locally before touching any cloud infrastructure.

**What to verify locally:**
- All containers show `Up` in `docker ps`
- Frontend loads at http://localhost:3000
- `/api/products` returns data via the gateway
- Prometheus scrapes metrics from `/metrics` endpoints
- Grafana dashboards show live data

---

## Stage 2: Source Control

Once a change is tested locally, it goes into Git.

```mermaid
gitGraph
   commit id: "initial"
   branch feature/new-endpoint
   commit id: "add endpoint"
   commit id: "add tests"
   checkout main
   merge feature/new-endpoint id: "PR merged"
   commit id: "ci: update image tags"
```

**The flow:**
1. Developer creates a feature branch
2. Makes changes, commits with clear messages
3. Opens a Pull Request on GitHub
4. PR is reviewed and merged into `main`
5. Merge to `main` triggers the CI pipeline automatically

Everything is tracked — who changed what, when, and why. This is the foundation of GitOps.

---

## Stage 3: CI Pipeline — GitHub Actions

On every push to `main`, GitHub Actions builds Docker images for all 7 services in parallel and pushes them to Amazon ECR.

```mermaid
flowchart TD
    Push[Push to main] --> Trigger[GitHub Actions triggered]

    Trigger --> B1[Build auth]
    Trigger --> B2[Build gateway]
    Trigger --> B3[Build product-service]
    Trigger --> B4[Build order-service]
    Trigger --> B5[Build orders]
    Trigger --> B6[Build user-service]
    Trigger --> B7[Build frontend]

    B1 & B2 & B3 & B4 & B5 & B6 & B7 --> Push2[Push all images to ECR]
    Push2 --> UM[update-manifests job]
    UM --> |Updates image tags in gitops/k8s/| Commit[Commits back to main]
```

**Key concepts:**
- Each service is a separate matrix job — they all build in parallel
- Images are tagged with the commit SHA for full traceability
- The `update-manifests` job patches the image tag in every Kubernetes manifest and commits the change back
- This commit is what ArgoCD detects to trigger a rollout

**Where to check:** GitHub repo → **Actions** tab → **Boutique CI Pipeline**

---

## Stage 4: Infrastructure — Terraform on AWS

Before the cluster can run anything, the infrastructure must exist. Terraform provisions everything from scratch.

```mermaid
flowchart TD
    TF[terraform apply] --> VPC[VPC — 3 AZs]
    VPC --> Sub1[Subnet us-east-1a]
    VPC --> Sub2[Subnet us-east-1b]
    VPC --> Sub3[Subnet us-east-1c]

    TF --> EKS[EKS Cluster]
    EKS --> NG[Node Group\nm7i-flex.large]
    Sub1 & Sub2 & Sub3 --> NG

    TF --> ECR1[ECR: frontend]
    TF --> ECR2[ECR: gateway]
    TF --> ECR3[ECR: auth]
    TF --> ECR4[ECR: ...]

    TF --> Helm1[Helm: ArgoCD\nnamespace: argocd]
    TF --> Helm2[Helm: kube-prometheus-stack\nnamespace: monitoring]
```

Terraform also installs ArgoCD and the Prometheus/Grafana stack into the cluster via Helm — so the entire platform is ready to receive workloads the moment `terraform apply` finishes.

---

## Stage 5: GitOps Deployment — ArgoCD

ArgoCD runs inside the cluster and watches the `main` branch. The moment the CI pipeline commits updated image tags back to Git, ArgoCD detects the change and rolls out the new version.

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant GH as GitHub (main)
    participant CI as GitHub Actions
    participant ECR as Amazon ECR
    participant Argo as ArgoCD
    participant EKS as EKS Cluster

    Dev->>GH: git push
    GH->>CI: trigger pipeline
    CI->>ECR: docker push (new image)
    CI->>GH: commit updated image tag
    Argo->>GH: polls every 3 mins / webhook
    GH-->>Argo: detects new commit
    Argo->>EKS: kubectl apply (rolling update)
    EKS-->>Argo: sync complete
```

**What ArgoCD does:**
- Continuously compares the desired state in Git against the live state in the cluster
- If they differ, it syncs — applying only what changed
- If someone manually changes something in the cluster, ArgoCD reverts it to match Git
- Every deployment is auditable — it's just a Git commit

**Key files:**
- `gitops/argo-cd.yml` — registers the repo and branch with ArgoCD
- `gitops/kustomization.yml` — lists all Kubernetes resources to apply
- `gitops/k8s/` — all service deployments, services, database, secrets

---

## Stage 6: Observability

Once the application is running in EKS, three layers of observability keep watch.

```mermaid
flowchart LR
    subgraph Services [boutique namespace]
        GW[gateway /metrics]
        AU[auth /metrics]
        PS[product-service /metrics]
        OS[order-service /metrics]
        OR[orders /metrics]
        US[user-service /metrics]
    end

    subgraph Monitoring [monitoring namespace]
        SM[ServiceMonitor] -->|scrape every 15s| PR[Prometheus]
        PR --> GR[Grafana\nDashboard]
    end

    subgraph Logging [amazon-cloudwatch namespace]
        FB[Fluent Bit] -->|pod logs| CW[CloudWatch\n/eks/boutique/pods]
    end

    GW & AU & PS & OS & OR & US --> SM
    GW & AU & PS & OS & OR & US --> FB
```

**Metrics — Prometheus + Grafana**
- Every service exposes a `/metrics` endpoint using `prom-client`
- A `ServiceMonitor` resource tells the Prometheus Operator which pods to scrape
- Grafana is pre-loaded with a boutique dashboard via a ConfigMap labelled `grafana_dashboard: "1"` — the Grafana sidecar auto-imports it

**Logs — Fluent Bit + CloudWatch**
- Fluent Bit runs as a DaemonSet in `amazon-cloudwatch`
- Captures stdout from every pod and ships logs to CloudWatch
- Log group: `/eks/boutique/pods`

**What to check in Grafana:**
- Request rate by service
- p95 / p99 response times
- 4xx and 5xx error rates
- Pod CPU and memory usage
- Pod restart count — surfaces crash loops early

---
## The Complete Picture

```mermaid
flowchart TD
    Dev[👩‍💻 Developer] -->|writes code| Local[Docker Compose\nLocal Testing]
    Local -->|git push| GH[GitHub main branch]
    GH -->|triggers| CI[GitHub Actions\nBuild + Push to ECR]
    CI -->|commits image tags| GH
    GH -->|ArgoCD detects change| Argo[ArgoCD\nRolling Deploy to EKS]
    Argo --> EKS[EKS Cluster\n7 microservices]
    EKS -->|metrics /metrics| Prom[Prometheus]
    EKS -->|pod logs| FB[Fluent Bit]
    Prom --> Grafana[Grafana\nDashboards]
    FB --> CW[CloudWatch\n/eks/boutique/pods]

    subgraph IaC [Infrastructure as Code]
        TF[Terraform\nVPC + EKS + ECR + Helm]
    end

    TF --> EKS
```
---