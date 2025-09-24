# 🌐 Terraform AWS ECS Fargate Infrastructure with Auto-Deploy

[![Terraform](https://img.shields.io/badge/Terraform-1.0+-purple?style=flat-square&logo=terraform)](https://terraform.io)
[![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=flat-square&logo=amazon-aws)](https://aws.amazon.com)
[![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)

This repository contains a **production-ready Terraform infrastructure** for deploying containerized applications on AWS using **ECS Fargate** with a complete **CI/CD auto-deployment pipeline**.

## 🚀 Key Features

- **🐳 ECS Fargate**: Serverless container orchestration
- **🔄 Auto-Deploy Pipeline**: ECR push → EventBridge → Lambda → ECS redeploy
- **🌐 Application Load Balancer**: High availability traffic distribution  
- **🔐 SSL/TLS**: Automated certificate management with ACM
- **🏗️ Modular Architecture**: Reusable Terraform modules
- **📊 MongoDB Atlas Integration**: Managed NoSQL database
- **🔒 Security**: IAM roles, Security Groups, private subnets
- **📋 Infrastructure as Code**: Complete GitOps workflow

## 🏗️ Architecture Overview

```
┌─────────────┐    ┌──────────────┐    ┌─────────────────┐
│   Route53   │───▶│  CloudFront  │───▶│ Application LB  │
│   (DNS)     │    │   + ACM SSL  │    │ (Public Subnet) │
└─────────────┘    └──────────────┘    └─────────┬───────┘
                                                  │
                                         ┌────────▼────────┐
                                         │  ECS Fargate    │
                                         │ (Private Subnet)│
                                         └────────┬────────┘
                                                  │
┌─────────────┐    ┌──────────────┐    ┌────────▼────────┐
│    ECR      │───▶│ EventBridge  │───▶│     Lambda      │
│ (Push Image)│    │  (Trigger)   │    │ (Auto-Deploy)   │
└─────────────┘    └──────────────┘    └─────────────────┘
```

## 📂 Project Structure

```
terraform-fargate-mongodb/
├── 📋 Configuration Files
│   ├── modules.tf          # Module orchestration
│   ├── variables.tf        # Input variables  
│   ├── providers.tf        # AWS provider config
│   └── backend.tf          # Remote state configuration
│
├── 🧱 Infrastructure Modules
│   ├── vpc/                # Virtual Private Cloud
│   ├── alb/                # Application Load Balancer
│   ├── ecs/                # ECS Cluster & Services
│   ├── ecr/                # Elastic Container Registry
│   ├── iam/                # Identity & Access Management
│   ├── lambda/             # Lambda Functions (generic)
│   ├── eventbridge/        # EventBridge Rules (generic)
│   ├── route53/            # DNS & Domain Management
│   └── acm/                # SSL Certificate Management
│
└── 🔧 Application Code
    └── lambda-functions/
        └── deployment-strategy.py  # Auto-deploy Lambda logic
```

## 🎯 Auto-Deploy Pipeline

The infrastructure includes a **fully automated deployment pipeline**:

### How it works:
```
1️⃣  Developer pushes new Docker image to ECR
     ↓
2️⃣  EventBridge detects ECR "image push" event
     ↓
3️⃣  Lambda function is triggered automatically
     ↓
4️⃣  Lambda updates ECS service (force new deployment)
     ↓
5️⃣  ECS Fargate pulls new image and redeploys
     ↓
6️⃣  ✅ Application updated with zero downtime
```

### Deployment Strategies:
- **FORCE**: Quick redeploy using existing task definition
- **REGISTER**: Create new task definition with specific image tag

## 🛠️ Infrastructure Components

| Component | Purpose | Configuration |
|-----------|---------|---------------|
| **VPC** | Network isolation | Public/Private subnets across AZs |
| **ALB** | Load balancing | SSL termination, health checks |
| **ECS** | Container orchestration | Fargate serverless compute |
| **ECR** | Container registry | Lifecycle policies, encryption |
| **Lambda** | Auto-deployment | Python 3.11, EventBridge triggered |
| **EventBridge** | Event routing | ECR push event filtering |
| **Route53** | DNS management | Domain & subdomain routing |
| **ACM** | SSL certificates | Automated validation & renewal |
| **IAM** | Security | Least privilege access policies |

## 🚀 Quick Start

### Prerequisites
- AWS CLI configured with appropriate permissions
- Terraform >= 1.0
- Docker for container builds

### 1. Clone Repository
```bash
git clone https://github.com/BetoNajera9/terraform-fargate-mongodb.git
cd terraform-fargate-mongodb
```

### 2. Configure Variables
Create `terraform.tfvars`:
```hcl
# AWS Configuration
aws_region = "us-east-1"

# MongoDB Atlas (Optional)
mongodbatlas_public_key  = "your-atlas-public-key"
mongodbatlas_private_key = "your-atlas-private-key"

# Networking
vpc_vpc_cidr = "10.0.0.0/16"
vpc_public_subnets = {
  "us-east-1a" = "10.0.1.0/24"
  "us-east-1b" = "10.0.2.0/24"
}
vpc_private_subnet = {
  "us-east-1a" = "10.0.10.0/24"
  "us-east-1b" = "10.0.11.0/24"
}

# Domain Configuration
route53_domain_name    = "your-domain.com"
route53_subdomain_name = "app.your-domain.com"
acm_subject_alternative_names = ["*.your-domain.com"]

# Application Configuration
ecs_container_name  = "my-app"
ecs_use_ecr        = true
ecr_repository_name = "my-app-repo"

# Auto-Deploy Configuration
autodeploy_deployment_strategy = "FORCE"  # or "REGISTER"
```

### 3. Deploy Infrastructure
```bash
# Initialize Terraform
terraform init

# Review execution plan
terraform plan

# Deploy infrastructure
terraform apply
```

### 4. Deploy Your Application
```bash
# Build and push your Docker image
docker build -t my-app .
docker tag my-app:latest <account-id>.dkr.ecr.<region>.amazonaws.com/my-app-repo:latest
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/my-app-repo:latest

# 🎉 Auto-deploy will trigger automatically within 30 seconds!
```

## 🔧 Configuration Options

### ECS Configuration
```hcl
ecs_cpu            = "512"     # CPU units (256, 512, 1024, etc.)
ecs_memory         = "1024"    # Memory in MiB
ecs_desired_count  = 1         # Number of running tasks
ecs_container_port = 80        # Port your app listens on
```

### Auto-Deploy Strategy
```hcl
# FORCE: Quick redeploy (recommended for development)
autodeploy_deployment_strategy = "FORCE"

# REGISTER: Create new task definition (recommended for production)
autodeploy_deployment_strategy = "REGISTER"
```

### Load Balancer Configuration
```hcl
alb_listener_port        = 443                    # HTTPS
alb_listener_protocol    = "HTTPS"
alb_tg_health_check_path = "/health"             # Health check endpoint
```

## 🔒 Security Features

- **🏠 VPC Isolation**: Applications run in private subnets
- **🛡️ Security Groups**: Restrictive firewall rules
- **🔐 IAM Roles**: Least privilege access
- **🔒 SSL/TLS**: End-to-end encryption
- **📊 CloudWatch**: Comprehensive logging and monitoring

## 📊 Monitoring & Logging

All components include comprehensive logging:
- **ECS Tasks**: CloudWatch Logs groups
- **Lambda Functions**: Execution logs and errors
- **Load Balancer**: Access logs and metrics
- **Auto-Deploy**: Deployment success/failure tracking

## 🔄 Auto-Deploy Lambda Function

The `deployment-strategy.py` Lambda function handles:
- **Event Filtering**: Only processes relevant ECR push events
- **Service Updates**: Triggers ECS service redeployment
- **Error Handling**: Comprehensive logging and error management
- **Strategy Selection**: Supports both FORCE and REGISTER strategies

## 🧪 Testing the Pipeline

1. **Make code changes** to your application
2. **Build new Docker image** with updated code
3. **Push image to ECR** using same repository
4. **Watch auto-deployment** happen automatically
5. **Verify update** on your application URL

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## � License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- 📧 Issues: [GitHub Issues](https://github.com/BetoNajera9/terraform-fargate-mongodb/issues)
- 📖 Documentation: [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- 💬 Community: [Terraform Community](https://discuss.hashicorp.com/c/terraform-core)

---

**Built with ❤️ using Terraform and AWS**
│
├── reusable base modules/
│   ├── lambda/             # Generic Lambda module
│   ├── eventbridge/        # Generic EventBridge rules
│   ├── iam/               # IAM roles and policies
│   ├── vpc/               # VPC and networking
│   ├── ecs/               # ECS cluster and services
│   ├── ecr/               # ECR repositories
│   ├── alb/               # Application Load Balancer
│   ├── route53/           # DNS management
│   └── acm/               # SSL certificates
│
├── feature modules/
│   └── ecr-autodeploy/    # ECR → ECS autodeploy feature
│
└── lambda-functions/
    └── ecr-autodeploy/    # Lambda source code
        └── lambda_deploy.py
```

---

## 🛠️ Prerequisites
- [Terraform >= 1.6](https://developer.hashicorp.com/terraform/downloads)
- AWS account with IAM credentials
- MongoDB Atlas account and API keys
- GitHub repository for version control

---

## ⚡ Usage
1. Clone this repository:
 ```bash
 git clone https://github.com/<your-username>/arena-terraform.git
 cd arena-terraform
 ```

2. Initialize Terraform:
 ```bash
 terraform init
 ```

3. Select or create a workspace:
 ```bash
 terraform workspace new dev
 terraform workspace select dev
 ```

4. Apply the configuration:
 ```bash
 terraform apply
 ```

---

## 📌 Roadmap
- [x] VPC and networking setup
- [x] ECS cluster with Fargate and ALB
- [x] ECR repository + auto-deploy trigger to ECS
- [ ] MongoDB Atlas integration
- [ ] CI/CD with GitHub Actions
- [ ] Sentinel policies for governance

---

## 🤝 Contributing
This is a learning project, but suggestions and improvements are welcome!

---

## 📜 License
MIT License. See [LICENSE](./LICENSE) for details.
