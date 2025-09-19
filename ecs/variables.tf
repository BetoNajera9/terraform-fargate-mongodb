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
