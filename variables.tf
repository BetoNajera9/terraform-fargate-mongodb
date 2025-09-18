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

variable "ecs_execution_role_arn" {
  description = "The ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "The ARN of the IAM role that containers in this task can assume"
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
  default     = 1
}

variable "ecs_sg_id" {
  description = "The ID of the security group to associate with the task or service"
  type        = string
}

