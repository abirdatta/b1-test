output "cw_log_group_name" {
  value = aws_cloudwatch_log_group.cw_log_group.name
}

output "cw_log_group_arn" {
  value = aws_cloudwatch_log_group.cw_log_group.arn
}

output "cw_log_stream_name" {
  value = aws_cloudwatch_log_stream.cw_log_stream.name
}