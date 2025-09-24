output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.deployment_strategy.arn
}

output "lambda_function_id" {
  description = "ID of the Lambda function"
  value       = aws_lambda_function.deployment_strategy.id
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.deployment_strategy.function_name
}

output "lambda_function_qualified_arn" {
  description = "Qualified ARN of the Lambda function (includes version)"
  value       = aws_lambda_function.deployment_strategy.qualified_arn
}

output "lambda_invoke_arn" {
  description = "ARN to be used for invoking Lambda Function from API Gateway"
  value       = aws_lambda_function.deployment_strategy.invoke_arn
}

output "lambda_log_group_arn" {
  description = "ARN of the CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.lambda_deployment_strategy_log_group.arn
}
