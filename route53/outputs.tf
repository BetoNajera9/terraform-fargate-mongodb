output "hosted_zone_id" {
  description = "The hosted zone ID"
  value       = aws_route53_zone.main_zone.zone_id
}

output "hosted_zone_name" {
  description = "The hosted zone name"
  value       = aws_route53_zone.main_zone.name
}

output "name_servers" {
  description = "The name servers for the hosted zone"
  value       = aws_route53_zone.main_zone.name_servers
}

output "subdomain_fqdn" {
  description = "The FQDN of the subdomain"
  value       = aws_route53_record.subdomain.fqdn
}
