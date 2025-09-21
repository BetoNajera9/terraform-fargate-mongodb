variable "domain_name" {
  description = "The domain name for which to request the certificate"
  type        = string
}

variable "hosted_zone_id" {
  description = "The Route53 hosted zone ID for DNS validation"
  type        = string
}

variable "subject_alternative_names" {
  description = "Additional domains to be included in the certificate"
  type        = list(string)
}

variable "validation_timeout" {
  description = "Timeout for certificate validation"
  type        = string
  default     = "10m"
}
