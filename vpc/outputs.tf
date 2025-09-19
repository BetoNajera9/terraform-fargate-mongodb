output "vpc_id" {
  description = "The ID of the main VPC"
  value       = aws_vpc.main_vpc.id
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public_subnet.id
}

output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private_subnet.id
}
