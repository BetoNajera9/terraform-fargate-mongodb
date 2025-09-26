module "vpc" {
  source = "./vpc"

  vpc_cidr       = var.vpc_vpc_cidr
  public_subnets = var.vpc_public_subnets
  private_subnet = var.vpc_private_subnet
}

module "alb" {
  source = "./alb"

  app_lb_name          = var.alb_app_lb_name
  sg_name              = var.alb_sg_name
  tg_name              = var.alb_tg_name
  tg_port              = var.alb_tg_port
  tg_protocol          = var.alb_tg_protocol
  tg_health_check_path = var.alb_tg_health_check_path
  listener_port        = var.alb_listener_port
  listener_protocol    = var.alb_listener_protocol

  vpc_main_vpc_id       = module.vpc.vpc_id
  vpc_public_subnets_id = module.vpc.vpc_public_subnets_id

  acm_ssl_certificate_arn = module.acm.acm_certificate_arn
  depends_on              = [module.acm]
}

module "iam" {
  source = "./iam"

  ecs_task_execution_role_name = var.iam_ecs_task_execution_role_name
  lambda_role_name             = var.iam_lambda_role_name
}

module "ecs" {
  source = "./ecs"

  cluster_name    = var.ecs_cluster_name
  task_family     = var.ecs_task_family
  cpu             = var.ecs_cpu
  memory          = var.ecs_memory
  container_name  = var.ecs_container_name
  container_image = var.ecs_use_ecr ? "${module.ecr.ecr_repository_url}:${var.ecs_image_tag}" : var.ecs_container_image
  container_port  = var.ecs_container_port

  aws_region = var.aws_region

  # MongoDB environment variables for Fargate application
  environment_variables = [
    {
      name  = "MONGODB_URI"
      value = module.mongodb.mongo_uri_srv
    },
    {
      name  = "MONGODB_DATABASE"
      value = module.mongodb.database_name
    },
    {
      name  = "MONGODB_USERNAME"
      value = module.mongodb.database_username
    },
    {
      name  = "NODE_ENV"
      value = "production"
    },
    {
      name  = "PORT"
      value = tostring(var.ecs_container_port)
    }
  ]

  iam_execution_role_arn = module.iam.iam_ecs_task_execution_role_arn

  vpc_private_subnets_id = module.vpc.vpc_private_subnets_id
  vpc_main_vpc_id        = module.vpc.vpc_id

  alb_target_group_arn  = module.alb.alb_target_group_arn
  alb_security_group_id = module.alb.alb_sg_id

  depends_on = [module.mongodb]
}

module "ecr" {
  source = "./ecr"

  repository_name      = var.ecr_repository_name
  image_tag_mutability = var.ecr_image_tag_mutability
  encryption_type      = var.ecr_encryption_type
}

module "route53" {
  source = "./route53"

  domain_name    = var.route53_domain_name
  subdomain_name = var.route53_subdomain_name

  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "acm" {
  source = "./acm"

  domain_name               = var.route53_subdomain_name
  subject_alternative_names = var.acm_subject_alternative_names
  validation_timeout        = var.acm_validation_timeout

  route53_hosted_zone_id = module.route53.route53_hosted_zone_id
}

module "lambda" {
  source = "./lambda"

  function_name = var.lambda_function_name
  handler       = var.lambda_handler

  iam_lambda_deployment_strategy_role_arn = module.iam.lambda_deployment_strategy_role_arn

  environment_variables = {
    CLUSTER             = module.ecs.cluster_id
    SERVICE             = module.ecs.service_name
    REPOSITORY_URI      = module.ecr.ecr_repository_url
    DEPLOYMENT_STRATEGY = var.autodeploy_deployment_strategy
    CONTAINER_NAME      = var.ecs_container_name
  }
}

module "eventbridge" {
  source = "./eventbridge"

  rule_name = var.event_bridge_rule_name
  state     = var.event_bridge_state

  ecr_repository_name = var.ecr_repository_name

  lambda_function_arn  = module.lambda.lambda_function_arn
  lambda_function_id   = module.lambda.lambda_function_id
  lambda_function_name = module.lambda.lambda_function_name
}

module "mongodb" {
  source = "./mongodb"

  # Organization configuration
  create_organization = var.mongodb_create_organization
  organization_name   = var.mongodb_organization_name
  org_id              = var.mongodb_org_id

  # Project and cluster configuration
  project_name                = var.mongodb_project_name
  cluster_name                = var.mongodb_cluster_name
  provider_region             = var.mongodb_provider_region
  provider_instance_size_name = var.mongodb_provider_instance_size_name
  mongodb_major_version       = var.mongodb_major_version

  # Features configuration
  auto_scaling_disk_gb_enabled = var.mongodb_auto_scaling_disk_gb_enabled
  pit_enabled                  = var.mongodb_pit_enabled
  backup_enabled               = var.mongodb_backup_enabled

  # Database user configuration
  database_username = var.mongodb_database_username
  database_password = var.mongodb_database_password
  database_name     = var.mongodb_database_name

  # Network access configuration
  ip_access_list = var.mongodb_ip_access_list

  # Optional VPC peering configuration (reusing existing VPC variables)
  vpc_cidr_block = var.mongodb_vpc_peering_enabled ? var.vpc_vpc_cidr : null
  aws_account_id = var.mongodb_vpc_peering_enabled ? var.aws_account_id : null
  vpc_id         = var.mongodb_vpc_peering_enabled ? module.vpc.vpc_id : null
  aws_region     = var.mongodb_vpc_peering_enabled ? var.aws_region : null
}
