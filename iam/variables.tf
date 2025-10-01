variable "ecs_task_execution_role_name" {
  description = "Nombre del rol de ejecución de ECS"
  type        = string
}

variable "lambda_role_name" {
  description = "Nombre del rol IAM para la función Lambda"
  type        = string
}
