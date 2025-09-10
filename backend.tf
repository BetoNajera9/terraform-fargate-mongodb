terraform {
  backend "remote" {
    organization = "beto-najera"

    workspaces {
      name = "terraform-fargate-mongodb"
    }
  }
}
