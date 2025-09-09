variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "mongodbatlas_public_key" {
  description = "The public key for MongoDB Atlas API access"
  type        = string
  sensitive   = true
}

variable "mongodbatlas_private_key" {
  description = "The private key for MongoDB Atlas API access"
  type        = string
  sensitive   = true
}
