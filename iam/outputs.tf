output "ecs_task_execution_role_arn" {
  description = "ARN del Execution Role de ECS"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_role_arn" {
  description = "ARN del Task Role de ECS"
  value       = aws_iam_role.ecs_task_role.arn
}
