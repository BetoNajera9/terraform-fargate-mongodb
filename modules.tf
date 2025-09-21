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
}

module "iam" {
  source = "./iam"

  ecs_task_execution_role_name = var.iam_ecs_task_execution_role_name
}

module "ecs" {
  source = "./ecs"

  cluster_name    = var.ecs_cluster_name
  task_family     = var.ecs_task_family
  cpu             = var.ecs_cpu
  memory          = var.ecs_memory
  container_name  = var.ecs_container_name
  container_image = var.ecs_container_image
  container_port  = var.ecs_container_port

  aws_region = var.aws_region

  iam_execution_role_arn = module.iam.iam_ecs_task_execution_role_arn

  vpc_private_subnets_id = module.vpc.vpc_private_subnets_id
  vpc_main_vpc_id        = module.vpc.vpc_id

  alb_target_group_arn  = module.alb.alb_target_group_arn
  alb_security_group_id = module.alb.alb_sg_id
}
