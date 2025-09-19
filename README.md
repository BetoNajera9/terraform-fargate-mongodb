# 🌐 Arena – Terraform Infrastructure

This repository contains the Terraform configuration for **Arena**, a project to practice and apply Infrastructure as Code (IaC) principles on AWS.
The setup provisions a modern cloud environment using:

- **ECS with Fargate** ⚡ – serverless containers for running applications
- **Application Load Balancer (ALB)** 🎯 – traffic distribution and high availability
- **MongoDB Atlas** 💽 – managed NoSQL database
- **Terraform modules, remote state, and workspaces** 📂 – best practices for scalable, maintainable infrastructure

---

## 🚀 Features
- VPC with public and private subnets
- ECS cluster on Fargate with a sample container
- Application Load Balancer for external access
- MongoDB Atlas cluster deployed via provider
- Remote state management with S3 + DynamoDB
- Environment separation using Terraform workspaces

---

## 📂 Project Structure
```
arena-terraform/
│── main.tf
│── provider.tf
│── variables.tf
│── outputs.tf
│── modules/
│ ├── network/
│ ├── ecs/
│ ├── alb/
│ └── mongo-atlas/
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
- [ ] MongoDB Atlas integration
- [ ] CI/CD with GitHub Actions
- [ ] Sentinel policies for governance

---

## 🤝 Contributing
This is a learning project, but suggestions and improvements are welcome!

---

## 📜 License
MIT License. See [LICENSE](./LICENSE) for details.
