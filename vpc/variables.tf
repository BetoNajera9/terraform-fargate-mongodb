variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnet CIDR blocks"
  type        = list(string)
}

variable "az" {
  description = "Availability zone"
  type        = string
}
