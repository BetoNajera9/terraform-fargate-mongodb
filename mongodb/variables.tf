variable "create_organization" {
  description = "Whether to create a new MongoDB Atlas organization"
  type        = bool
  default     = true
}

variable "organization_name" {
  description = "Name of the MongoDB Atlas organization (required if create_organization is true)"
  type        = string
  default     = "terraform-fargate-mongodb-organization"

  validation {
    condition     = var.create_organization == false || (var.create_organization == true && var.organization_name != null && var.organization_name != "")
    error_message = "organization_name is required when create_organization is true."
  }
}

variable "org_owner_id" {
  description = "MongoDB Atlas organization owner ID (required if create_organization is true)"
  type        = string
  default     = null

  validation {
    condition     = var.create_organization == false || (var.create_organization == true && var.org_owner_id != null && var.org_owner_id != "")
    error_message = "org_owner_id is required when create_organization is true."
  }
}

variable "org_id" {
  description = "MongoDB Atlas organization ID (required if create_organization is false)"
  type        = string
  default     = null

  validation {
    condition     = var.create_organization == true || (var.create_organization == false && var.org_id != null && var.org_id != "")
    error_message = "org_id is required when create_organization is false."
  }
}

variable "project_name" {
  description = "Name of the MongoDB Atlas project"
  type        = string
  default     = "terraform-fargate-mongodb-project"
}

variable "cluster_name" {
  description = "Name of the MongoDB Atlas cluster"
  type        = string
  default     = "terraform-fargate-mongodb-cluster"
}

variable "provider_region" {
  description = "Region for the MongoDB Atlas cluster"
  type        = string
  default     = "US_EAST_1"
}

variable "provider_instance_size_name" {
  description = "Instance size for the MongoDB Atlas cluster (M0 = Free, M2/M5 = Shared, M10+ = Dedicated)"
  type        = string
  default     = "M0"
}

variable "mongodb_major_version" {
  description = "MongoDB version"
  type        = string
  default     = "7.0"
}

variable "auto_scaling_disk_gb_enabled" {
  description = "Enable auto scaling for disk space (only available for M10+ clusters)"
  type        = bool
  default     = false
}

variable "pit_enabled" {
  description = "Enable Point in Time Recovery (only available for M10+ clusters)"
  type        = bool
  default     = false
}

variable "backup_enabled" {
  description = "Enable backup for the cluster (only available for M10+ clusters)"
  type        = bool
  default     = false
}

variable "database_username" {
  description = "Username for the database user"
  type        = string
  sensitive   = true
}

variable "database_password" {
  description = "Password for the database user"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Name of the database"
  type        = string
  default     = "myapp"
}

variable "ip_access_list" {
  description = "List of IP addresses or CIDR blocks allowed to access the cluster"
  type = list(object({
    ip_address = string
    comment    = string
  }))
  default = []
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC peering (if using private networking)"
  type        = string
  default     = null
}

variable "aws_account_id" {
  description = "AWS Account ID for VPC peering"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "VPC ID for peering connection"
  type        = string
  default     = null
}

variable "aws_region" {
  description = "AWS region for VPC peering"
  type        = string
  default     = null
}
