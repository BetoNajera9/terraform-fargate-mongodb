resource "aws_security_group" "alb_sg" {
  name        = var.sg_name
  description = "Allow HTTP and HTTPS traffic"
  vpc_id      = var.vpc_main_vpc_id

  tags = {
    Name = var.sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_lb" "app_lb" {
  name               = var.app_lb_name
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.vpc_public_subnets_id

  tags = {
    Name = var.app_lb_name
  }
}

resource "aws_lb_target_group" "app_tg" {
  name        = var.tg_name
  port        = var.tg_port
  protocol    = var.tg_protocol
  vpc_id      = var.vpc_main_vpc_id
  target_type = "ip"

  health_check {
    path                = var.tg_health_check_path
    protocol            = var.tg_protocol
    port                = "traffic-port"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 5
    matcher             = "200-399"
  }

  tags = {
    Name = var.tg_name
  }
}

resource "aws_lb_listener" "app_listener_http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  # Dynamic action: redirect to HTTPS if enabled, otherwise forward to target group
  default_action {
    type = var.enable_https_listener ? "redirect" : "forward"

    # Redirect action (only when HTTPS is enabled)
    dynamic "redirect" {
      for_each = var.enable_https_listener ? [1] : []
      content {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    # Forward action (only when HTTPS is disabled)
    target_group_arn = var.enable_https_listener ? null : aws_lb_target_group.app_tg.arn
  }
}

resource "aws_lb_listener" "app_listener_https" {
  count = var.enable_https_listener ? 1 : 0

  load_balancer_arn = aws_lb.app_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.acm_ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
