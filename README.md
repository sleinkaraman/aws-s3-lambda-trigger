
# AWS S3 Lambda Trigger Lab (Event-Driven Architecture) 🚀

An **Infrastructure as Code (IaC)** project demonstrating an event-driven serverless architecture. This lab automates the deployment of a system where an **AWS S3** bucket triggers a **Python Lambda** function upon file upload, simulated locally via **LocalStack**.

## 🛠 Tech Stack
- **Terraform:** Infrastructure orchestration and automated ZIP packaging.
- **LocalStack:** Local cloud service emulation (S3, Lambda, IAM, CloudWatch Logs).
- **Python 3.11:** Backend logic for the Lambda function.
- **Docker:** Containerization for the local cloud environment.

## 📂 Project Architecture
- `src/index.py`: The Python source code that processes S3 events.
- `main.tf`: Core logic for S3, Lambda, and the event-driven notification bridge.
- `provider.tf`: LocalStack endpoint configurations.
- `variables.tf` & `outputs.tf`: For reusable and observable infrastructure.



## 🚀 Deployment & Testing

### 1. Initialize the Local Environment
Ensure Docker is running, then start the local cloud:
```
docker-compose up -d
```
### 2. Deploy with Terraform
Terraform will automatically zip the Python source code and deploy it:
```
terraform init
terraform apply -auto-approve
```

### 3. Trigger the Event
Upload a file to the S3 bucket to trigger the Lambda function:
```
echo "Hello World" > test-trigger.txt
aws --endpoint-url=http://localhost:4566 s3 cp test-trigger.txt s3://selin-trigger-bucket/
```

### 4. Verify Logs
Monitor the real-time execution logs from the Lambda function:
```
aws --endpoint-url=http://localhost:4566 logs tail /aws/lambda/s3-event-processor --follow
```

## 🧠 Key Learning Outcomes
- Automated Provisioning: Used Terraform's archive_file to package application code on the fly.
- Serverless Event-Driven Design: Implemented the aws_s3_bucket_notification resource to bridge storage and compute.
- Cloud Observability: Configured and monitored CloudWatch Logs to debug serverless execution.
- IAM & Permissions: Managed the least-privilege principle using aws_lambda_permission to allow S3 to invoke Lambda.









