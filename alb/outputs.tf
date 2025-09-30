output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.app_lb.arn
}

output "alb_dns_name" {
  description = "DNS público del ALB"
  value       = aws_lb.app_lb.dns_name
}

output "alb_zone_id" {
  description = "Hosted Zone ID del ALB (para integrarlo con Route53)"
  value       = aws_lb.app_lb.zone_id
}

output "alb_sg_id" {
  description = "Security Group asociado al ALB"
  value       = aws_security_group.alb_sg.id
}

output "alb_listener_http_arn" {
  description = "ARN del listener HTTP del ALB"
  value       = aws_lb_listener.app_listener_http.arn
}

output "alb_listener_https_arn" {
  description = "ARN del listener HTTPS del ALB"
  value       = var.enable_https_listener ? aws_lb_listener.app_listener_https[0].arn : null
}

output "alb_target_group_arn" {
  description = "ARN del Target Group del ALB"
  value       = aws_lb_target_group.app_tg.arn
}
