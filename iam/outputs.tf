output "iam_ecs_task_execution_role_arn" {
  description = "ARN del Execution Role de ECS"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "lambda_deployment_strategy_role_arn" {
  description = "ARN del rol de ejecución de Lambda"
  value       = aws_iam_role.lambda_deployment_strategy_role.arn
}
