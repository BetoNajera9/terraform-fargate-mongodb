output "vpc_id" {
  description = "The ID of the main VPC"
  value       = aws_vpc.main_vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the main VPC"
  value       = aws_vpc.main_vpc.cidr_block
}

output "vpc_public_subnets_id" {
  description = "The ID of the public subnets"
  value       = [for s in aws_subnet.public_subnets : s.id]
}

output "vpc_private_subnets_id" {
  description = "The ID of the private subnets"
  value       = [for s in aws_subnet.private_subnets : s.id]
}

output "vpc_route_table_ids" {
  description = "List of route table IDs for VPC peering routes (private for Fargate, public for Bastion)"
  value = [
    aws_route_table.private_crt.id,
    aws_route_table.public_crt.id
  ]
}

output "vpc_public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_crt.id
}

output "vpc_private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private_crt.id
}
