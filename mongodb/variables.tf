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

variable "provider_type" {
  description = "Type of the MongoDB Atlas cluster"
  type        = string
  default     = "REPLICASET"

  validation {
    condition     = contains(["REPLICASET", "SHARED", "GEOSHARDED"], var.provider_type)
    error_message = "Provider type (${var.provider_type}) must be one of: REPLICASET, SHARED, GEOSHARDED"
  }
}

variable "provider_name" {
  description = "Cloud provider for the MongoDB Atlas cluster (AWS, GCP, AZURE)"
  type        = string
  default     = "TENANT"

  validation {
    condition     = contains(["AWS", "GCP", "AZURE", "TENANT", "FLEX"], var.provider_name)
    error_message = "Provider name (${var.provider_name}) must be one of: AWS, GCP, AZURE, TENANT"
  }
}

variable "backing_provider_name" {
  description = "Cloud provider for the MongoDB Atlas cluster (AWS, GCP, AZURE) - Only used when provider_name is TENANT or FLEX"
  type        = string
  default     = "AWS"

  validation {
    condition = (
      (var.provider_name == "TENANT" || var.provider_name == "FLEX") && contains(["AWS", "GCP", "AZURE"], var.backing_provider_name)
      ) || (
      contains(["AWS", "GCP", "AZURE"], var.provider_name)
    )
    error_message = "When provider_name is TENANT or FLEX, backing_provider_name must be one of: AWS, GCP, AZURE. When provider_name is AWS, GCP, or AZURE, backing_provider_name is used as provider_name."
  }
}

variable "provider_region" {
  description = "Region for the MongoDB Atlas cluster"
  type        = string
  default     = "US_WEST_1"
}

variable "instance_size" {
  description = "Instance size for the MongoDB Atlas cluster"
  type        = string
  default     = "M0"
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
  default     = "terraform-fargate-mongodb-db"
}

variable "ip_access_list" {
  description = "List of IP addresses or CIDR blocks allowed to access the cluster"
  type = list(object({
    ip_address = string
    comment    = string
  }))
  default = [
    {
      ip_address = "0.0.0.0/0"
      comment    = "Allow all IPs - Update this for production with specific CIDR blocks"
    }
  ]

  validation {
    condition     = length(var.ip_access_list) > 0
    error_message = "At least one IP address or CIDR block must be specified in ip_access_list."
  }
}

# Refused from VPC module
variable "vpc_cidr_block" {
  description = "VPC CIDR block for peering connection (from VPC module)"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "VPC ID for peering connection (from VPC module)"
  type        = string
  default     = null
}

variable "vpc_route_table_ids" {
  description = "List of VPC route table IDs to add routes for MongoDB Atlas peering"
  type        = list(string)
  default     = null
}

# Refuased from AWS module
variable "aws_account_id" {
  description = "AWS Account ID for VPC peering (from AWS data source)"
  type        = string
  default     = null
}

variable "aws_region" {
  description = "AWS region for VPC peering (from AWS provider)"
  type        = string
  default     = null
}

variable "atlas_cidr_block" {
  description = "MongoDB Atlas network container CIDR block (must not overlap with VPC CIDR)"
  type        = string
  default     = "10.100.0.0/16"

  validation {
    condition     = can(cidrhost(var.atlas_cidr_block, 0))
    error_message = "The atlas_cidr_block must be a valid CIDR block."
  }
}
