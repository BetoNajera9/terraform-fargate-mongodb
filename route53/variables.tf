variable "domain_name" {
  description = "The domain name for the hosted zone"
  type        = string
}

variable "subdomain_name" {
  description = "The subdomain name to create"
  type        = string
}

# Refused from ALB module
variable "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  type        = string
}

variable "alb_zone_id" {
  description = "The zone ID of the Application Load Balancer"
  type        = string
}
