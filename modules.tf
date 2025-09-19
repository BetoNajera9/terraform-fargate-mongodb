module "vpc" {
  source = "./vpc"

  vpc_cidr = var.vpc_vpc_cidr
  subnets  = var.vpc_subnets
  az       = var.vpc_az
}

module "ecs" {
  source = "./ecs"

  cluster_name       = var.ecs_cluster_name
  task_family        = var.ecs_task_family
  cpu                = var.ecs_cpu
  memory             = var.ecs_memory
  execution_role_arn = var.ecs_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn
  container_name     = var.ecs_container_name
  container_image    = var.ecs_container_image
  container_port     = var.ecs_container_port
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
}
