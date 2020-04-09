resource "aws_elasticache_subnet_group" "ec_subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
  description = var.description
}