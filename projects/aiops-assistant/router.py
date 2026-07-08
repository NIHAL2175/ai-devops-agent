import json
from gemini_client import ask_gemini

SYSTEM_PROMPT = """
You are an AI DevOps Agent.

Available tools:

1. fetch_logs
   - Retrieve CloudWatch logs.

2. fetch_metrics
   - Retrieve CloudWatch metrics.

3. fetch_service_health
   - Check Kubernetes/EKS service health.

Your task is NOT to answer the user's question.

Your task is ONLY to decide which tool(s) are needed.

Return ONLY valid JSON.

Example:

{
  "tools": ["fetch_logs", "fetch_metrics"],
  "reason": "Need logs and metrics."
}
"""

def plan(prompt: str):
    response = ask_gemini(
        SYSTEM_PROMPT + "\n\nUser Question:\n" + prompt
    )

    return json.loads(response)