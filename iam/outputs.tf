output "iam_ecs_task_execution_role_arn" {
  description = "ARN del Execution Role de ECS"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_logs_policy_arn" {
  description = "ARN de la política de logs para ECS"
  value       = aws_iam_policy.ecs_logs_policy.arn
}
