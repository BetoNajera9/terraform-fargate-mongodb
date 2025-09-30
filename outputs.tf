# ======================================
# Output Values
# ======================================

# === VPC Information ===
output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.vpc_public_subnets_id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.vpc_private_subnets_id
}

# === Load Balancer Information ===
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = module.alb.alb_zone_id
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

# === ECS Information ===
output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = module.ecs.cluster_id
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs.service_name
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.ecs.task_definition_arn
}

# === ECR Information ===
output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.ecr_repository_url
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = module.ecr.ecr_repository_arn
}

# === Domain and SSL Information ===
output "domain_name" {
  description = "The configured domain name (if custom domain is enabled)"
  value       = var.enable_custom_domain ? var.route53_subdomain_name : null
}

output "hosted_zone_id" {
  description = "Route53 hosted zone ID (if custom domain is enabled)"
  value       = var.enable_custom_domain ? module.route53[0].route53_hosted_zone_id : null
}

output "ssl_certificate_arn" {
  description = "ARN of the SSL certificate (if custom domain is enabled)"
  value       = var.enable_custom_domain ? module.acm[0].acm_certificate_arn : null
}

output "nameservers" {
  description = "Route53 nameservers for domain configuration (if custom domain is enabled)"
  value       = var.enable_custom_domain ? module.route53[0].route53_name_servers : null
}

# === MongoDB Information ===
output "mongodb_connection_string" {
  description = "MongoDB Atlas connection string (SRV format)"
  value       = module.mongodb.mongo_uri_srv
  sensitive   = true
}

output "mongodb_cluster_id" {
  description = "MongoDB Atlas cluster ID"
  value       = module.mongodb.cluster_id
}

output "mongodb_project_id" {
  description = "MongoDB Atlas project ID"
  value       = module.mongodb.project_id
}

output "mongodb_database_name" {
  description = "MongoDB database name"
  value       = module.mongodb.database_name
}

# === Lambda Information ===
output "auto_deploy_lambda_arn" {
  description = "ARN of the auto-deployment Lambda function"
  value       = module.lambda.lambda_function_arn
}

output "auto_deploy_lambda_name" {
  description = "Name of the auto-deployment Lambda function"
  value       = module.lambda.lambda_function_name
}

# === EventBridge Information ===
output "eventbridge_rule_arn" {
  description = "ARN of the EventBridge rule for auto-deployment"
  value       = module.eventbridge.event_bridge_rule_arn
}

# === Application URLs ===
output "application_url_http" {
  description = "HTTP URL to access the application"
  value       = "http://${module.alb.alb_dns_name}"
}

output "application_url_https" {
  description = "HTTPS URL to access the application (if custom domain is enabled)"
  value       = var.enable_custom_domain ? "https://${var.route53_subdomain_name}" : null
}

# === Quick Start Commands ===
output "ecr_login_command" {
  description = "Command to login to ECR"
  value       = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${module.ecr.ecr_repository_url}"
}

output "docker_push_commands" {
  description = "Commands to build and push Docker image to ECR"
  value = [
    "docker build -t ${var.ecr_repository_name} .",
    "docker tag ${var.ecr_repository_name}:latest ${module.ecr.ecr_repository_url}:latest",
    "docker push ${module.ecr.ecr_repository_url}:latest"
  ]
}

# === Environment Variables for Applications ===
output "environment_variables" {
  description = "Environment variables that will be injected into ECS tasks"
  value = {
    MONGODB_URI      = module.mongodb.mongo_uri_srv
    MONGODB_DATABASE = module.mongodb.database_name
    MONGODB_USERNAME = module.mongodb.database_username
    NODE_ENV         = "production"
    PORT             = var.ecs_container_port
  }
  sensitive = true
}
