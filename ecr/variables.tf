variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting for the repository"
  type        = string
}

variable "encryption_type" {
  description = "Encryption type for the repository (KMS or AES256)"
  type        = string
}
