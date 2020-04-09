output "db_subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group.name
}

output "db_subnet_group_subnet_ids" {
  value = aws_db_subnet_group.db_subnet_group.subnet_ids
}