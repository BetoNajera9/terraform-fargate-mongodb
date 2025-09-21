output "vpc_id" {
  description = "The ID of the main VPC"
  value       = aws_vpc.main_vpc.id
}

output "vpc_public_subnets_id" {
  description = "The ID of the public subnets"
  value       = [for s in aws_subnet.public_subnets : s.id]
}

output "vpc_private_subnets_id" {
  description = "The ID of the private subnets"
  value       = [for s in aws_subnet.private_subnets : s.id]
}
