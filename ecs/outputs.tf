output "cluster_id" {
  value = aws_ecs_cluster.main_ecs.id
}

output "service_name" {
  value = aws_ecs_service.ecs_service.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.ecs_task.arn
}
