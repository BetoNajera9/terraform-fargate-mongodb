variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "mongodbatlas_public_key" {
  description = "The public key for MongoDB Atlas API access"
  type        = string
  sensitive   = true
}

variable "mongodbatlas_private_key" {
  description = "The private key for MongoDB Atlas API access"
  type        = string
  sensitive   = true
}

# VPC Module Variables
variable "vpc_vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_public_subnets" {
  description = "Map of AZs to public subnet CIDR blocks"
  type        = map(string)
}

variable "vpc_private_subnet" {
  description = "Map of AZ to private subnet CID blocks"
  type        = map(string)
}

# ALB Variables
variable "alb_app_lb_name" {
  description = "Nombre del Application Load Balancer"
  type        = string
  default     = "app-alb"
}

variable "alb_sg_name" {
  description = "Nombre del Security Group para el ALB"
  type        = string
  default     = "alb-sg"
}

variable "alb_tg_name" {
  description = "Nombre del Target Group"
  type        = string
  default     = "app-tg"
}

variable "alb_tg_port" {
  description = "Puerto donde escucha el Target Group"
  type        = number
  default     = 80
}

variable "alb_tg_protocol" {
  description = "Protocolo para el Target Group"
  type        = string
  default     = "HTTP"
}

variable "alb_tg_health_check_path" {
  description = "Path para el health check del ALB"
  type        = string
  default     = "/"
}

variable "alb_listener_port" {
  description = "Puerto en el que escucha el listener"
  type        = number
  default     = 80
}

variable "alb_listener_protocol" {
  description = "Protocolo del listener"
  type        = string
  default     = "HTTP"
}

# IAM Variables
variable "iam_ecs_task_execution_role_name" {
  description = "Nombre del rol de ejecución de ECS"
  type        = string
  default     = "ecsTaskExecutionRole"
}

variable "iam_lambda_role_name" {
  description = "Nombre del rol IAM para la función Lambda"
  type        = string
  default     = "lambdaRole"
}

# ECS Variables
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "ecs-cluster"
}

variable "ecs_task_family" {
  description = "The family of the ECS task definition"
  type        = string
  default     = "nginx-app"
}

variable "ecs_cpu" {
  description = "The number of CPU units used by the task"
  type        = string
  default     = 512
}

variable "ecs_memory" {
  description = "The amount of memory (in MiB) used by the task"
  type        = string
  default     = 1024
}

variable "ecs_container_name" {
  description = "The name of the container"
  type        = string
  default     = "nginx-container"
}

variable "ecs_container_image" {
  description = "The image used to start a container"
  type        = string
  default     = "nginx:latest"
}

variable "ecs_use_ecr" {
  description = "If true, deploy the image from the ECR repository created by this stack"
  type        = bool
  default     = false
}

variable "ecs_image_tag" {
  description = "Image tag to deploy from ECR (ignored if ecs_use_ecr=false)"
  type        = string
  default     = "latest"
}

variable "ecs_container_port" {
  description = "The port number on the container that is bound to the user-specified or automatically assigned host port"
  type        = number
  default     = 80
}

variable "ecs_desired_count" {
  description = "The number of instances of the task definition to place and keep running in your service"
  type        = number
  default     = 1
}

# Route 53 Variables
variable "route53_domain_name" {
  description = "The domain name for the hosted zone"
  type        = string
}

variable "route53_subdomain_name" {
  description = "The subdomain name to create"
  type        = string
}

# ACM (SSL Certificate) Variables
variable "acm_subject_alternative_names" {
  description = "Additional domains to include in the SSL certificate"
  type        = list(string)
}

variable "acm_validation_timeout" {
  description = "Timeout for ACM certificate validation"
  type        = string
  default     = "10m"
}

# ECR Variables
variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "my-ecr-repo"
}

variable "ecr_image_tag_mutability" {
  description = "Image tag mutability (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"
}

variable "ecr_encryption_type" {
  description = "Encryption type for ECR repo (AES256 or KMS)"
  type        = string
  default     = "AES256"
}
