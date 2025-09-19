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

variable "vpc_subnets" {
  description = "List of subnet CIDR blocks"
  type        = list(string)
}

variable "vpc_az" {
  description = "Availability zone"
  type        = string
}

# ALB Variables
variable "alb_app_lb_name" {
  description = "Nombre del Application Load Balancer"
  type        = string
}

variable "alb_sg_name" {
  description = "Nombre del Security Group para el ALB"
  type        = string
}

variable "alb_tg_name" {
  description = "Nombre del Target Group"
  type        = string
}

variable "alb_tg_port" {
  description = "Puerto donde escucha el Target Group"
  type        = number
}

variable "alb_tg_protocol" {
  description = "Protocolo para el Target Group"
  type        = string
}

variable "alb_tg_health_check_path" {
  description = "Path para el health check del ALB"
  type        = string
}

variable "alb_listener_port" {
  description = "Puerto en el que escucha el listener"
  type        = number
}

variable "alb_listener_protocol" {
  description = "Protocolo del listener"
  type        = string
}

# IAM Variables
variable "iam_ecs_task_execution_role_name" {
  description = "Nombre del rol de ejecución de ECS"
  type        = string
}

variable "iam_ecs_task_role_name" {
  description = "Nombre del rol de task de ECS"
  type        = string
}

# ECS Variables
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "ecs_task_family" {
  description = "The family of the ECS task definition"
  type        = string
}

variable "ecs_cpu" {
  description = "The number of CPU units used by the task"
  type        = string
}

variable "ecs_memory" {
  description = "The amount of memory (in MiB) used by the task"
  type        = string
}

variable "ecs_container_name" {
  description = "The name of the container"
  type        = string
}

variable "ecs_container_image" {
  description = "The image used to start a container"
  type        = string
}

variable "ecs_container_port" {
  description = "The port number on the container that is bound to the user-specified or automatically assigned host port"
  type        = number
}

variable "ecs_desired_count" {
  description = "The number of instances of the task definition to place and keep running in your service"
  type        = number
}

variable "ecs_sg_id" {
  description = "The ID of the security group to associate with the task or service"
  type        = string
}
