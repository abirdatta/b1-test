output "alb_dns" {
  value = aws_lb.application.dns_name
}

output "alb_name" {
  value = aws_lb.application.name
}

output "alb_arn" {
  value = aws_lb.application.arn
}

output "alb_id" {
  value = aws_lb.application.id
}

output "target_group_arn" {
  value = aws_lb_target_group.tg.arn
}