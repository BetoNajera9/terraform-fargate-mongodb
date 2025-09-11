module "vpc" {
  source    = "./vpc"
  vpc_cidr  = var.vpc_vpc_cidr
  subnets   = var.vpc_subnets
  az        = var.vpc_az
}