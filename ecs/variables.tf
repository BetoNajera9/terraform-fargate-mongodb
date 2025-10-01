variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "task_family" {
  description = "The family of the ECS task definition"
  type        = string
}

variable "cpu" {
  description = "The number of CPU units used by the task"
  type        = string
}

variable "memory" {
  description = "The amount of memory (in MiB) used by the task"
  type        = string
}

variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "container_image" {
  description = "The image used to start a container"
  type        = string
}

variable "container_port" {
  description = "The port number on the container that is bound to the user-specified or automatically assigned host port"
  type        = number
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running in your service"
  type        = number
}

variable "sg_name" {
  description = "The name of the security group for ECS tasks"
  type        = string
}

# Refused from IAM module
variable "iam_execution_role_arn" {
  description = "The ARN of the IAM role that allows your Amazon ECS container agent to make AWS API calls on your behalf"
  type        = string
}

# Refused from VPC module
variable "vpc_private_subnets_id" {
  description = "The ID of the private subnets where the ECS tasks will be launched"
  type        = list(string)
}

variable "vpc_main_vpc_id" {
  description = "The ID of the main VPC where the ECS tasks will be launched"
  type        = string
}

# Refused from ALB module
variable "alb_target_group_arn" {
  description = "The ARN of the ALB target group to associate with the ECS service"
  type        = string
}

variable "alb_security_group_id" {
  description = "The security group ID of the ALB to allow traffic from ALB to ECS tasks"
  type        = string
}

variable "aws_region" {
  description = "AWS region for logs configuration"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables to pass to the container"
  type = list(object({
    name  = string
    value = string
  }))
}
