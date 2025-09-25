output "event_bridge_rule_arn" {
  description = "ARN of the EventBridge rule"
  value       = aws_cloudwatch_event_rule.ecr_when_push_rule.arn
}

output "event_bridge_rule_name" {
  description = "Name of the EventBridge rule"
  value       = aws_cloudwatch_event_rule.ecr_when_push_rule.name
}

output "event_bridge_target_arn" {
  description = "ARN of the lambda target"
  value       = aws_cloudwatch_event_target.lambda_target.arn
}
