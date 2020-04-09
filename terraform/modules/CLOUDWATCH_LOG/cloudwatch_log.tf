resource "aws_cloudwatch_log_group" "cw_log_group" {
  name = var.log_group_name
  retention_in_days = var.retention_in_days
  kms_key_id = var.kms_key_id
  tags = var.tags
}

resource "aws_cloudwatch_log_stream" "cw_log_stream" {
  name           = var.log_stream_name
  log_group_name = aws_cloudwatch_log_group.cw_log_group.name
}
