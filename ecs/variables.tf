variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "ecs-cluster"
}

variable "task_family" {
  description = "The family of the ECS task definition"
  type        = string
  default     = "nginx-app"
}

variable "cpu" {
  description = "The number of CPU units used by the task"
  type        = string
  default     = 512
}

variable "memory" {
  description = "The amount of memory (in MiB) used by the task"
  type        = string
  default     = 1024
}

variable "container_name" {
  description = "The name of the container"
  type        = string
  default     = "nginx-container"
}

variable "container_image" {
  description = "The image used to start a container"
  type        = string
  default     = "nginx:latest"
}

variable "container_port" {
  description = "The port number on the container that is bound to the user-specified or automatically assigned host port"
  type        = number
  default     = 80
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running in your service"
  type        = number
  default     = 1
}

variable "sg_name" {
  description = "The name of the security group for ECS tasks"
  type        = string
  default     = "ecs-sg"
}

# Refused from IAM module
variable "iam_execution_role_arn" {
  description = "The ARN of the IAM role that allows your Amazon ECS container agent to make AWS API calls on your behalf"
  type        = string
}

variable "iam_task_role_arn" {
  description = "The ARN of the IAM role that allows your task to make AWS API calls"
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
