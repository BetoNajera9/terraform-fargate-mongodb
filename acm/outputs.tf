output "acm_certificate_arn" {
  description = "The ARN of the SSL certificate"
  value       = var.wait_for_validation ? aws_acm_certificate_validation.ssl_validation[0].certificate_arn : aws_acm_certificate.ssl_certificate.arn
}

output "acm_certificate_domain_name" {
  description = "The domain name for which the certificate was issued"
  value       = aws_acm_certificate.ssl_certificate.domain_name
}

output "acm_certificate_status" {
  description = "The status of the certificate"
  value       = aws_acm_certificate.ssl_certificate.status
}

output "acm_certificate_validation_emails" {
  description = "List of email addresses used for validation (if email validation was used)"
  value       = aws_acm_certificate.ssl_certificate.validation_emails
}

output "acm_domain_validation_options" {
  description = "The domain validation options"
  value       = aws_acm_certificate.ssl_certificate.domain_validation_options
  sensitive   = true
}
