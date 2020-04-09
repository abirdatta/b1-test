resource "aws_s3_bucket" "logging_bucket" {
  count = var.logging_enabled ? 1 : 0
  bucket = var.log_bucket_name
  acl    = "private"

  tags = {
    Name        = var.log_bucket_name
    Environment = var.env
  }
}

resource "aws_lb" "application" {
  load_balancer_type               = "application"
  name                             = var.load_balancer_name
  internal                         = var.load_balancer_is_internal
  security_groups                  = var.security_groups
  subnets                          = var.subnets
  idle_timeout                     = var.idle_timeout
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.enable_deletion_protection
  enable_http2                     = var.enable_http2
  ip_address_type                  = var.ip_address_type
  tags = merge(
  var.tags,
  {
    "Name" = var.load_balancer_name
  },
  )

  access_logs {
    enabled = var.logging_enabled
    bucket  = var.log_bucket_name
    prefix  = var.log_location_prefix
  }

  timeouts {
    create = var.load_balancer_create_timeout
    delete = var.load_balancer_delete_timeout
    update = var.load_balancer_update_timeout
  }
}

resource "aws_lb_target_group" "tg" {
  name     = var.target_group_name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  target_type = var.target_type
  stickiness {
    enabled = var.stickiness_enabled
    type = "lb_cookie"
  }
  health_check {
    enabled = true
    interval = var.health_check_interval
    healthy_threshold = var.health_check_healthy_threshold
    path = var.health_check_path
    port = var.health_check_port
    protocol = var.health_check_protocol
    timeout = var.health_check_timeout
    unhealthy_threshold = var.health_check_unhealthy_threshold
    matcher = var.health_check_matcher
  }
  tags = {
    Name = var.load_balancer_name
    env = var.env
  }
}

resource "aws_lb_listener" "frontend_http_tcp" {
  load_balancer_arn = aws_lb.application.arn
  port     = var.port
  protocol = var.protocol

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }
}
