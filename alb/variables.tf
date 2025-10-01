variable "app_lb_name" {
  description = "Nombre del Application Load Balancer"
  type        = string
}

variable "sg_name" {
  description = "Nombre del Security Group para el ALB"
  type        = string
}

variable "tg_name" {
  description = "Nombre del Target Group"
  type        = string
}

variable "tg_port" {
  description = "Puerto donde escucha el Target Group"
  type        = number
}

variable "tg_protocol" {
  description = "Protocolo para el Target Group"
  type        = string
}

variable "tg_health_check_path" {
  description = "Path para el health check del ALB"
  type        = string
}

variable "listener_port" {
  description = "Puerto en el que escucha el listener"
  type        = number
}

# Refused from ACM module
variable "acm_ssl_certificate_arn" {
  description = "ARN of the SSL certificate from ACM"
  type        = string
}

variable "enable_https_listener" {
  description = "Whether to create HTTPS listener (requires SSL certificate)"
  type        = bool
}

# Reused from VPC module
variable "vpc_main_vpc_id" {
  description = "The ID of the main VPC"
  type        = string
}

variable "vpc_public_subnets_id" {
  description = "The ID of the public subnets"
  type        = list(string)
}
