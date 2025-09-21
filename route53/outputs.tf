output "route53_hosted_zone_id" {
  description = "The hosted zone ID"
  value       = aws_route53_zone.main_zone.zone_id
}

output "route53_hosted_zone_name" {
  description = "The hosted zone name"
  value       = aws_route53_zone.main_zone.name
}

output "route53_name_servers" {
  description = "The name servers for the hosted zone"
  value       = aws_route53_zone.main_zone.name_servers
}

output "route53_subdomain_fqdn" {
  description = "The FQDN of the subdomain"
  value       = aws_route53_record.subdomain.fqdn
}
