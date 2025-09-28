# Create MongoDB Atlas Organization (optional)
resource "mongodbatlas_organization" "terraform-fargate-mongodb-organization" {
  count = var.create_organization ? 1 : 0

  name         = var.organization_name
  org_owner_id = var.org_owner_id
  description  = "Organization created by Terraform for ${var.project_name}"
}

# Local value to determine the organization ID to use
locals {
  org_id = var.create_organization ? mongodbatlas_organization.terraform-fargate-mongodb-organization[0].org_id : var.org_id
}

# Create MongoDB Atlas Project
resource "mongodbatlas_project" "terraform-fargate-mongodb-project" {
  name   = var.project_name
  org_id = local.org_id

  is_collect_database_specifics_statistics_enabled = true
  is_data_explorer_enabled                         = true
  is_extended_storage_sizes_enabled                = true
  is_performance_advisor_enabled                   = true
  is_realtime_performance_panel_enabled            = true
  is_schema_advisor_enabled                        = true

  depends_on = [mongodbatlas_organization.terraform-fargate-mongodb-organization]
}

# Create MongoDB Atlas Cluster
resource "mongodbatlas_advanced_cluster" "terraform-fargate-mongodb-cluster" {
  project_id   = mongodbatlas_project.terraform-fargate-mongodb-project.id
  name         = var.cluster_name
  cluster_type = var.provider_type

  replication_specs = [
    {
      region_configs = [
        {
          electable_specs = {
            instance_size = var.instance_size
          }
          provider_name         = var.provider_name
          backing_provider_name = var.backing_provider_name
          region_name           = var.provider_region
          priority              = 7
        }
      ]
    }
  ]
}

# Create database user
resource "mongodbatlas_database_user" "database_user" {
  username           = var.database_username
  password           = var.database_password
  project_id         = mongodbatlas_project.terraform-fargate-mongodb-project.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = var.database_name
  }

  roles {
    role_name     = "dbAdmin"
    database_name = var.database_name
  }

  depends_on = [mongodbatlas_advanced_cluster.terraform-fargate-mongodb-cluster]
}

resource "mongodbatlas_project_ip_access_list" "main" {
  count = length(var.ip_access_list)

  project_id = mongodbatlas_project.terraform-fargate-mongodb-project.id

  # Use cidr_block if the ip_address contains a slash (CIDR notation), otherwise use ip_address
  ip_address = can(regex("/", var.ip_access_list[count.index].ip_address)) ? null : var.ip_access_list[count.index].ip_address
  cidr_block = can(regex("/", var.ip_access_list[count.index].ip_address)) ? var.ip_access_list[count.index].ip_address : null

  comment = var.ip_access_list[count.index].comment

  depends_on = [mongodbatlas_advanced_cluster.terraform-fargate-mongodb-cluster]
}

resource "mongodbatlas_network_peering" "main" {
  count = var.vpc_cidr_block != null ? 1 : 0

  project_id             = mongodbatlas_project.terraform-fargate-mongodb-project.id
  container_id           = mongodbatlas_network_container.main.container_id
  accepter_region_name   = var.aws_region
  provider_name          = "AWS"
  route_table_cidr_block = var.vpc_cidr_block
  vpc_id                 = var.vpc_id
  aws_account_id         = var.aws_account_id

  depends_on = [mongodbatlas_network_container.main]
}

resource "mongodbatlas_network_container" "main" {
  count = var.vpc_cidr_block != null ? 1 : 0

  project_id       = mongodbatlas_project.terraform-fargate-mongodb-project.id
  atlas_cidr_block = "192.168.248.0/21"
  provider_name    = "AWS"
  region_name      = var.provider_region

  depends_on = [mongodbatlas_project.terraform-fargate-mongodb-project]
}
