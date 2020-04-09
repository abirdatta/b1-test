output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.db_instance.address
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.db_instance.arn
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = aws_db_instance.db_instance.availability_zone
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.db_instance.endpoint
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.db_instance.id
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = aws_db_instance.db_instance.status
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.db_instance.name
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = aws_db_instance.db_instance.username
}

output "db_instance_password" {
  description = "The master username for the database"
  value       = aws_db_instance.db_instance.password
}

output "db_instance_port" {
  description = "The database port"
  value       = aws_db_instance.db_instance.port
}