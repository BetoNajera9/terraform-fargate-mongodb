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

variable "execution_role_arn" {
  description = "The ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume"
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the IAM role that containers in this task can assume"
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
  default     = 1
}

variable "subnets" {
  description = "A list of subnet IDs for the task or service"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "The ID of the security group to associate with the task or service"
  type        = string
}
