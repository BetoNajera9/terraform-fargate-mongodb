resource "aws_route53_zone" "main_zone" {
  name = var.domain_name

  tags = {
    Name = var.domain_name
  }
}

resource "aws_route53_record" "subdomain" {
  zone_id = aws_route53_zone.main_zone.zone_id
  name    = var.subdomain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }

  depends_on = [aws_route53_zone.main_zone]
}
