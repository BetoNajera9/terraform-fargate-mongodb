variable "app_lb_name" {
  description = "Nombre del Application Load Balancer"
  type        = string
  default     = "app-alb"
}

variable "sg_name" {
  description = "Nombre del Security Group para el ALB"
  type        = string
  default     = "alb-sg"
}

variable "tg_name" {
  description = "Nombre del Target Group"
  type        = string
  default     = "app-tg"
}

variable "tg_port" {
  description = "Puerto donde escucha el Target Group"
  type        = number
  default     = 80
}

variable "tg_protocol" {
  description = "Protocolo para el Target Group"
  type        = string
  default     = "HTTP"
}

variable "tg_health_check_path" {
  description = "Path para el health check del ALB"
  type        = string
  default     = "/"
}

variable "listener_port" {
  description = "Puerto en el que escucha el listener"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Protocolo del listener"
  type        = string
  default     = "HTTP"
}

# Reused from VPC module
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_main_vpc_id" {
  description = "The ID of the main VPC"
  type        = string
}
