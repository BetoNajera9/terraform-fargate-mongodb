module "vpc" {
  source   = "./vpc"
  vpc_cidr = var.vpc_vpc_cidr
  subnets  = var.vpc_subnets
  az       = var.vpc_az
}

module "ecs" {
  source             = "./ecs"
  cluster_name       = var.ecs_cluster_name
  task_family        = var.ecs_task_family
  cpu                = var.ecs_cpu
  memory             = var.ecs_memory
  execution_role_arn = var.ecs_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn
  container_name     = var.ecs_container_name
  container_image    = var.ecs_container_image
  container_port     = var.ecs_container_port
  subnets            = var.vpc_subnets
  ecs_sg_id          = module.vpc.vpc_default_sg_id
}
