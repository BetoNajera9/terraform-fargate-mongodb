variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "my-ecr-repo"
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting for the repository"
  type        = string
  default     = "IMMUTABLE"
}

variable "encryption_type" {
  description = "Encryption type for the repository (KMS or AES256)"
  type        = string
  default     = "AES256"
}
