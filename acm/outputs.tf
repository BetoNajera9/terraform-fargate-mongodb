output "certificate_arn" {
  description = "The ARN of the SSL certificate"
  value       = aws_acm_certificate_validation.ssl_validation.certificate_arn
}

output "certificate_domain_name" {
  description = "The domain name for which the certificate was issued"
  value       = aws_acm_certificate.ssl_certificate.domain_name
}

output "certificate_status" {
  description = "The status of the certificate"
  value       = aws_acm_certificate.ssl_certificate.status
}

output "certificate_validation_emails" {
  description = "List of email addresses used for validation (if email validation was used)"
  value       = aws_acm_certificate.ssl_certificate.validation_emails
}

output "domain_validation_options" {
  description = "The domain validation options"
  value       = aws_acm_certificate.ssl_certificate.domain_validation_options
  sensitive   = true
}
