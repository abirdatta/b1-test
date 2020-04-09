output "vpc_id" {
  value = module.b1-test_vpc.vpc_id
}

output "private_compute_subnet_ids" {
  value = module.compute_private_subnets.subnet_ids
}

output "private_compute_subnet_cidrs" {
  value = module.compute_private_subnets.subnet_cidrs
}

output "private_db_subnet_ids" {
  value = module.db_private_subnets.subnet_ids
}

output "private_db_subnet_cidrs" {
  value = module.db_private_subnets.subnet_cidrs
}

output "public_compute_subnet_ids" {
  value = module.compute_public_subnets.subnet_ids
}

output "public_compute_subnet_cidrs" {
  value = module.compute_public_subnets.subnet_cidrs
}

output "rds_db_security_group_id" {
  value = module.rds_db_security_group.security_group_id
}

output "alb_security_group_id" {
  value = module.alb_security_group.security_group_id
}

output "ec2_security_group_id" {
  value = module.ec2_security_group.security_group_id
}

output "ecs_cluster_id" {
  value = module.ecs_cluster.cluster_id
}

output "alb_dns" {
  value = module.alb_and_target_group.alb_dns
}

output "alb_arn" {
  value = module.alb_and_target_group.alb_arn
}

output "alb_id" {
  value = module.alb_and_target_group.alb_id
}

output "alb_name" {
  value = module.alb_and_target_group.alb_name
}

output "target_group_arn" {
  value = module.alb_and_target_group.target_group_arn
}
