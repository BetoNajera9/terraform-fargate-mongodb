variable "domain_name" {
  description = "The domain name for which to request the certificate"
  type        = string
}

variable "subject_alternative_names" {
  description = "Additional domains to be included in the certificate"
  type        = list(string)
}

variable "validation_timeout" {
  description = "Timeout for certificate validation"
  type        = string
}

variable "wait_for_validation" {
  description = "Whether to wait for the certificate validation to complete. Set to false to avoid timeout errors when nameservers are not properly configured."
  type        = bool
}

# Refused from Route 53 module
variable "route53_hosted_zone_id" {
  description = "The Route53 hosted zone ID for DNS validation"
  type        = string
}
