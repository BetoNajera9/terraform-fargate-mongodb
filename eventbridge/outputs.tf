output "event_bridge_rule_arn" {
  description = "ARN of the EventBridge rule"
  value       = aws_cloudwatch_event_rule.this.arn
}

output "event_bridge_rule_name" {
  description = "Name of the EventBridge rule"
  value       = aws_cloudwatch_event_rule.this.name
}

output "event_bridge_target_arn" {
  description = "ARN of the lambda target"
  value       = aws_cloudwatch_event_target.lambda_target.arn
}
