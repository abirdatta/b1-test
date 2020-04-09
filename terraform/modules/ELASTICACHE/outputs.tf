output "replication_group_id" {
  value = aws_elasticache_replication_group.ec_replication_group.id
}

output "primary_endpoint_address" {
  value = aws_elasticache_replication_group.ec_replication_group.primary_endpoint_address
}

output "engine" {
  value = aws_elasticache_replication_group.ec_replication_group.engine
}

output "engine_version" {
  value = aws_elasticache_replication_group.ec_replication_group.engine_version
}

output "member_clusters" {
  value = aws_elasticache_replication_group.ec_replication_group.member_clusters
}