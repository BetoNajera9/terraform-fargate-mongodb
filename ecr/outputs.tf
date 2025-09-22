output "ecr_repository_url" {
  description = "Full URI of the ECR repository"
  value       = aws_ecr_repository.main_repository.repository_url
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.main_repository.arn
}
