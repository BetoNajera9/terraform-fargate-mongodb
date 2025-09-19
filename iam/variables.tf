variable "ecs_task_execution_role_name" {
  description = "Nombre del rol de ejecución de ECS"
  type        = string
  default     = "ecsTaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "Nombre del rol de task de ECS"
  type        = string
  default     = "ecsTaskRoleTest"
}
