# RDS outputs
output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.maria.db_instance_address
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.maria.db_instance_arn
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = module.maria.db_instance_availability_zone
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.maria.db_instance_endpoint
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = module.maria.db_instance_id
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = module.maria.db_instance_status
}

output "db_instance_name" {
  description = "The database name"
  value       = module.maria.db_instance_name
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = module.maria.db_instance_username
}

output "db_instance_password" {
  description = "The master username for the database"
  value       = module.maria.db_instance_password
}

output "db_instance_port" {
  description = "The database port"
  value       = module.maria.db_instance_port
}
