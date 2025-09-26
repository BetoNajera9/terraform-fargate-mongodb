output "organization_id" {
  description = "MongoDB Atlas organization ID (created or existing)"
  value       = local.org_id
}

output "organization_name" {
  description = "MongoDB Atlas organization name"
  value       = var.create_organization ? mongodbatlas_org.main[0].name : "Existing organization (ID: ${var.org_id})"
}

output "project_id" {
  description = "MongoDB Atlas project ID"
  value       = mongodbatlas_project.main.id
}

output "cluster_id" {
  description = "MongoDB Atlas cluster ID"
  value       = mongodbatlas_cluster.main.cluster_id
}

output "cluster_name" {
  description = "MongoDB Atlas cluster name"
  value       = mongodbatlas_cluster.main.name
}

output "connection_strings" {
  description = "MongoDB connection strings"
  value       = mongodbatlas_cluster.main.connection_strings
  sensitive   = true
}

output "mongo_uri" {
  description = "MongoDB URI for application connection"
  value       = mongodbatlas_cluster.main.connection_strings[0].standard
  sensitive   = true
}

output "mongo_uri_srv" {
  description = "MongoDB SRV URI for application connection"
  value       = mongodbatlas_cluster.main.connection_strings[0].standard_srv
  sensitive   = true
}

output "database_username" {
  description = "Database username"
  value       = mongodbatlas_database_user.main.username
}

output "database_name" {
  description = "Database name"
  value       = var.database_name
}

output "cluster_state" {
  description = "Current state of the cluster"
  value       = mongodbatlas_cluster.main.state_name
}

output "srv_address" {
  description = "SRV address for the cluster"
  value       = mongodbatlas_cluster.main.srv_address
}

output "mongo_db_version" {
  description = "MongoDB version"
  value       = mongodbatlas_cluster.main.mongo_db_version
}

output "peering_connection_id" {
  description = "VPC peering connection ID (if created)"
  value       = var.vpc_cidr_block != null && var.aws_account_id != null && var.vpc_id != null ? mongodbatlas_network_peering.main[0].connection_id : null
}
