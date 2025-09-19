output "cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.main_ecs.id
}

output "service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.ecs_service.name
}

output "task_definition_arn" {
  description = "The ARN of the ECS task definition"
  value       = aws_ecs_task_definition.ecs_task.arn
}
