variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of AZs to public subnet CIDR blocks"
  type        = map(string)
}

variable "private_subnet" {
  description = "Map of AZ to private subnet CID blocks"
  type        = map(string)
}
