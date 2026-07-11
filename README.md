<div align="center">

# 🚀 Cloud-Native Boutique Microservices Platform

![Microservices](https://img.shields.io/badge/Microservices-Architecture-0078D4)
![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-EF7B4D?logo=argo)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?logo=kubernetes)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?logo=prometheus)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-4169E1?logo=postgresql)

<img src="Architecture/arch.png" width="100%">

</div>

---

# 📖 Project Overview

This project demonstrates how a modern cloud-native application is designed, containerized, deployed, monitored and continuously delivered using industry-standard DevOps tools and AWS services.

The application follows a **Microservices Architecture**, where each business capability runs as an independent service inside an Amazon EKS Kubernetes cluster.

Instead of manually deploying applications, the project follows a **GitOps workflow**, where Git remains the single source of truth and ArgoCD continuously synchronizes the Kubernetes cluster with the latest repository changes.

Infrastructure provisioning is fully automated using Terraform, while GitHub Actions handles continuous integration by building Docker images, pushing them to Amazon ECR and updating Kubernetes manifests automatically.

The platform also includes a complete observability stack using Prometheus, Grafana, AlertManager, Fluent Bit and Amazon CloudWatch for monitoring, alerting, visualization, and centralized log management.

---

# 🎯 Project Objectives

- Designing a cloud-native microservices architecture
- Containerizing applications using Docker
- Running the application locally using Docker Compose
- Provisioning AWS infrastructure using Terraform
- Deploying workloads on Amazon EKS
- Implementing GitOps using ArgoCD
- Automating CI pipelines using GitHub Actions
- Storing container images in Amazon ECR
- Managing secrets using AWS Secrets Manager
- Configuring IAM Roles for Service Accounts (IRSA)
- Monitoring applications using Prometheus and Grafana
- Configuring AlertManager for alerting
- Centralizing application logs using Fluent Bit and CloudWatch
- Demonstrating production-inspired Kubernetes deployments

---

# ✨ Key Features

## ☁️ Cloud Infrastructure

- Amazon VPC
- Amazon EKS Cluster
- Managed Node Groups
- Amazon ECR
- AWS IAM
- IAM OIDC Provider
- IAM Roles for Service Accounts (IRSA)
- AWS Secrets Manager

---

## 🐳 Containerization

- Docker
- Docker Compose
- Multi-service Architecture
- Independent Service Images
- Container Networking

---

## ☸ Kubernetes

- Deployments
- Services
- ConfigMaps
- Secrets
- Service Accounts
- Rolling Updates
- Replica Management
- Namespace Isolation

---

## 🚀 CI/CD

- GitHub Actions
- Automated Docker Builds
- Amazon ECR Push
- Automatic Image Versioning
- Manifest Updates
- GitOps Continuous Delivery

---

## 🔄 GitOps

- ArgoCD
- Auto Sync
- Self Heal
- Pruning
- Desired State Management
- Automated Rollouts

---

## 📊 Observability

- Prometheus
- Grafana
- AlertManager
- Fluent Bit
- Amazon CloudWatch
- Metrics Collection
- Dashboards
- Alerting
- Centralized Logging

---

## 🗄 Database

- PostgreSQL
- Product Catalog
- User Management
- Order Management
- Authentication Data

---

# 📂 Project Directories

| Folder | Description |
|----------|-------------|
| 📁 terraform | AWS Infrastructure as Code |
| 📁 gitops | ArgoCD Applications & Kubernetes Manifests |
| 📁 projects | Microservices Source Code |
| 📁 frontend | React Frontend |
| 📁 gateway | API Gateway |
| 📁 auth | Authentication Service |
| 📁 product-service | Product Catalog Service |
| 📁 order-service | Order Processing Service |
| 📁 orders | Order Management Service |
| 📁 user-service | User Management Service |
| 📁 database | PostgreSQL Initialization Scripts |
| 📁 monitoring | Prometheus & Grafana Configuration |
| 📁 docs | Project Documentation |
| 📁 Architecture | Architecture Diagrams |

---

# 🛠 Technology Stack

| Layer | Technology | Purpose |
|---------|------------|----------|
| Frontend | React | User Interface |
| Backend | Node.js / Express | Microservices |
| Database | PostgreSQL | Persistent Storage |
| API Gateway | Express Gateway | Request Routing |
| Containerization | Docker | Application Packaging |
| Local Development | Docker Compose | Multi-container Environment |
| Container Registry | Amazon ECR | Image Storage |
| Orchestration | Amazon EKS | Kubernetes Platform |
| Infrastructure | Terraform | Infrastructure as Code |
| CI | GitHub Actions | Continuous Integration |
| CD | ArgoCD | GitOps Deployment |
| Metrics | Prometheus | Monitoring |
| Visualization | Grafana | Dashboards |
| Alerting | AlertManager | Notifications |
| Logging | Fluent Bit | Log Collection |
| Log Storage | Amazon CloudWatch | Centralized Logging |
| Secrets | AWS Secrets Manager | Secret Management |
| Authentication | IAM + IRSA | Secure AWS Access |
| Version Control | GitHub | Source Code Management |

---
# 🔄 End-to-End DevOps Workflow

```
Developer
    │
    ▼
Local Development (Docker Compose)
    │
    ▼
Git Commit & Push
    │
    ▼
GitHub Repository
    │
    ▼
GitHub Actions CI Pipeline
    │
    ├──────────────► Build Docker Images
    │
    ├──────────────► Push Images to Amazon ECR
    │
    └──────────────► Update Kubernetes Image Tags
                     │
                     ▼
               GitHub Repository
                     │
                     ▼
              ArgoCD Auto Sync
                     │
                     ▼
             Amazon EKS Cluster
                     │
     ┌───────────────┼────────────────┐
     ▼               ▼                ▼
 Prometheus      Fluent Bit      PostgreSQL
     │               │
     ▼               ▼
 Grafana       CloudWatch Logs
     │
     ▼
AlertManager
```

---

# 👨‍💻 Local Development Environment

| Service | Port |
|----------|------|
| Frontend | 3000 |
| API Gateway | 3001 |
| Authentication Service | 3002 |
| Product Service | 3003 |
| Order Service | 3004 |
| Orders Service | 3005 |
| User Service | 3006 |
| Grafana | 3007 |
| PostgreSQL | 5432 |
| Prometheus | 9090 |

---

## Start Local Environment

```bash
docker compose up -d
```

---

## Verify Running Containers

```bash
docker compose ps
```

Expected Output

```
Frontend
Gateway
Auth
Product Service
Order Service
Orders Service
User Service
PostgreSQL
Prometheus
Grafana
```

---

## Verify Application
```
Frontend
http://localhost:3000
```

```
Gateway API
http://localhost:3001
```

```
Prometheus
http://localhost:9090
```

```
Grafana
http://localhost:3007
```

---

# 🐳 Docker Implementation

## Dockerized Services

- Frontend
- Gateway
- Authentication
- Product Service
- Order Service
- Orders Service
- User Service

---

## Docker Workflow

```
Source Code
      │
      ▼
Docker Build
      │
      ▼
Docker Image
      │
      ▼
Amazon ECR
      │
      ▼
Amazon EKS
```

---

## Benefits

- Consistent runtime
- Environment isolation
- Lightweight deployments
- Faster scaling
- Easy portability
- Independent service deployment

---

# 📦 Docker Compose Architecture

Docker Compose creates an isolated network where every microservice communicates using internal DNS names.

```
                Docker Network

                     Frontend
                         │
                         ▼
                   API Gateway
       ┌────────────┼─────────────┐
       ▼            ▼             ▼
 Authentication   Products     Orders
       │            │             │
       └──────┬─────┴──────┬──────┘
              ▼            ▼
        User Service   PostgreSQL

Prometheus scrapes every service.

Grafana visualizes Prometheus metrics.
```

---

# ⚙️ GitHub Actions

## CI Pipeline Stages

```
Push to Main
      │
      ▼
Checkout Repository
      │
      ▼
Build Microservices
      │
      ▼
Build Docker Images
      │
      ▼
Authenticate with AWS
      │
      ▼
Push Images to Amazon ECR
      │
      ▼
Update Kubernetes Manifests
      │
      ▼
Commit Updated Image Tags
```

---

## Pipeline Responsibilities

- Checkout repository
- Configure AWS credentials
- Authenticate with Amazon ECR
- Build all Docker images
- Push images to Amazon ECR
- Generate image tags
- Update Kubernetes deployment manifests
- Commit updated image versions
- Trigger GitOps deployment

---

## Services Built

The workflow builds Docker images for every microservice in parallel.

- Frontend
- Gateway
- Authentication
- Product Service
- Order Service
- Orders Service
- User Service

---

# 📦 Amazon Elastic Container Registry (ECR)

## ECR Workflow

```
GitHub Actions
        │
        ▼
Docker Build
        │
        ▼
Amazon ECR
        │
        ▼
ArgoCD
        │
        ▼
Amazon EKS
```

---

## Benefits

- Secure image storage
- Private container registry
- Version-controlled images
- AWS native integration
- High availability
- Lifecycle policies

---

# 🏗 Infrastructure as Code (Terraform)

## Resources Provisioned

- Amazon VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- Route Tables
- Security Groups
- Amazon EKS Cluster
- Managed Node Group
- Amazon ECR Repositories
- IAM Roles
- IAM Policies
- IAM OIDC Provider
- Helm Releases
- ArgoCD
- kube-prometheus-stack

---

## Terraform Architecture

```
Terraform
      │
      ▼
AWS Infrastructure
      │
      ├────────► VPC
      ├────────► Subnets
      ├────────► Security Groups
      ├────────► Amazon EKS
      ├────────► Amazon ECR
      ├────────► IAM Roles
      ├────────► OIDC Provider
      ├────────► ArgoCD
      └────────► Monitoring Stack
```

---

## Why Terraform?

Using Terraform provides several advantages:

- Infrastructure as Code
- Version-controlled infrastructure
- Repeatable deployments
- Reduced manual configuration
- Easy disaster recovery
- Automated provisioning
- Environment consistency

---

# 🚀 Continuous Delivery Overview

Once GitHub Actions updates the Kubernetes manifests with the latest image tags, the GitOps workflow takes over.

ArgoCD continuously monitors the Git repository, detects manifest changes, and synchronizes the Amazon EKS cluster automatically.

This eliminates manual deployment commands and ensures the running cluster always matches the desired state stored in Git.

---
# ☸️ Amazon EKS Deployment

## Kubernetes Resources

| Resource | Purpose |
|----------|---------|
| Namespace | Resource Isolation |
| Deployment | Manages Pods |
| ReplicaSet | Ensures Desired Replicas |
| Pods | Runs Containers |
| Service | Internal Service Discovery |
| ConfigMap | Configuration Management |
| Secret | Secure Credentials |
| ServiceAccount | AWS Authentication using IRSA |

---

## Kubernetes Architecture

```
Amazon EKS Cluster

┌────────────────────────────────────────────┐
│ Namespace : boutique                       │
│                                            │
│ Frontend                                   │
│ Gateway                                    │
│ Authentication Service                     │
│ Product Service                            │
│ Order Service                              │
│ Orders Service                             │
│ User Service                               │
│ PostgreSQL                                 |
│                                            │
└────────────────────────────────────────────┘
```

---

## Deployment Characteristics

- Rolling Updates
- Zero Downtime Deployments
- Independent Scaling
- Self Healing Pods
- Service Discovery
- Namespace Isolation
- Internal Networking

---

# 🔄 GitOps with ArgoCD

## GitOps Workflow

```
Developer
      │
      ▼
GitHub Repository
      │
      ▼
GitHub Actions
      │
      ▼
Update Kubernetes Manifests
      │
      ▼
ArgoCD Detects Changes
      │
      ▼
Automatic Synchronization
      │
      ▼
Amazon EKS Cluster
```

---

## ArgoCD Features

- Automated Synchronization
- Self Healing
- Drift Detection
- Continuous Deployment
- Desired State Management
- Automatic Rollbacks
- Deployment History

---

## Why GitOps?

GitOps simplifies Kubernetes management by making Git the source of truth.

Benefits include:

- Declarative Infrastructure
- Version Controlled Deployments
- Easy Rollbacks
- Automated Synchronization
- Audit Trail
- Reproducible Environments

---

# 📊 Monitoring with Prometheus

## Metrics Collected

- HTTP Requests
- Response Time
- Error Rate
- CPU Usage
- Memory Usage
- Pod Health
- Container Status
- Kubernetes Metrics

---

## Monitoring Flow

```
Microservices
       │
       ▼
ServiceMonitor
       │
       ▼
Prometheus
       │
       ▼
Grafana
```

---

## Benefits

- Real-time Monitoring
- Time-Series Metrics
- Kubernetes Integration
- Historical Data
- Alert Integration

---

# 📈 Grafana Dashboards

## Dashboard Metrics

- Request Rate
- API Latency
- Success Rate
- Error Rate
- CPU Usage
- Memory Usage
- Pod Status
- Node Utilization
- Network Traffic

---

## Dashboard Benefits

- Interactive Charts
- Live Monitoring
- Historical Analysis
- Custom Dashboards
- Kubernetes Visualization

---

# 🚨 AlertManager

## Alert Categories

- High CPU Usage
- High Memory Usage
- Pod Failures
- Application Errors
- High Latency
- Service Down
- Kubernetes Events

---

## Alert Flow

```
Prometheus
      │
      ▼
Alert Rules
      │
      ▼
AlertManager
      │
      ▼
Notification Channels
```

---

# 📜 Centralized Logging

## Logging Architecture

```
Application Pods
       │
       ▼
Fluent Bit
       │
       ▼
CloudWatch Logs
```

---

## Logging Benefits

- Centralized Logs
- Kubernetes Integration
- Searchable Logs
- Historical Retention
- Troubleshooting
- Operational Visibility

---

# ☁️ Amazon CloudWatch

## CloudWatch Features

- Centralized Log Storage
- Log Streams
- Search & Filter
- Historical Logs
- Operational Monitoring

---

# 🗄 PostgreSQL Database

## Database Responsibilities

- Product Catalog
- User Accounts
- Authentication Data
- Order Records
- Inventory Information

---

## Database Benefits

- Relational Database
- ACID Transactions
- High Reliability
- Structured Data
- Production Ready

---

# 📂 Project Structure

```
Cloud-Native-Boutique-Microservices/

├── .github/
│   └── workflows/
│
├── Architecture/
│
├── docs/
│
├── terraform/
│   ├── eks/
│   ├── vpc/
│   ├── ecr/
│   ├── iam/
│   └── monitoring/
│
├── gitops/
│   ├── argocd/
│   ├── k8s/
│   └── manifests/
│
├── projects/
│   └── boutique-microservices/
│       ├── frontend/
│       ├── gateway/
│       ├── auth/
│       ├── product-service/
│       ├── order-service/
│       ├── orders/
│       ├── user-service/
│       ├── database/
│       ├── monitoring/
│       ├── docker-compose.yml
│       └── Dockerfiles
│
├── README.md
```

---

# 🚀 Production Highlights

✔ Cloud-Native Microservices

✔ Dockerized Services

✔ Docker Compose Development

✔ Infrastructure as Code

✔ Amazon EKS Deployment

✔ GitOps using ArgoCD

✔ GitHub Actions CI

✔ Amazon ECR Registry

✔ Prometheus Monitoring

✔ Grafana Dashboards

✔ AlertManager Integration

✔ Fluent Bit Logging

✔ Amazon CloudWatch Logs

✔ PostgreSQL Database

✔ Secure AWS Authentication using IAM, OIDC & IRSA

✔ Automated Deployment Pipeline

---

<div align="center">

# 👨‍💻 Author

## **NIHAL N**

**DevOps • Cloud • Kubernetes**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Nihal%20N-blue?logo=linkedin)](https://www.linkedin.com/in/nihal-n-cse/)

---

##  If you found this project useful, consider giving it a ⭐ !

</div>
