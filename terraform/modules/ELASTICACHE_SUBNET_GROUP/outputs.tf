output "ec_subnet_group_name" {
  value = aws_elasticache_subnet_group.ec_subnet_group.name
}

output "ec_subnet_group_subnet_ids" {
  value = aws_elasticache_subnet_group.ec_subnet_group.subnet_ids
}