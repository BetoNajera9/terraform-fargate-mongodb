terraform {
  required_version = ">= 1.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.12.0"
    }

    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.41.0"
    }
  }

  cloud {
    organization = "beto-najera"
    workspaces {
      name = "terraform-fargate-mongodb"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "mongodbatlas" {
  public_key  = var.mongodbatlas_public_key
  private_key = var.mongodbatlas_private_key
}
