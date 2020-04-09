resource "aws_elasticache_replication_group" "ec_replication_group" {
  automatic_failover_enabled    = var.automatic_failover_enabled
  availability_zones            = var.az
  replication_group_id          = var.replication_group_id
  replication_group_description = var.replication_group_description
  number_cache_clusters         = var.number_cache_clusters
  tags = var.tags
  maintenance_window   = var.maintenance_window
  security_group_ids   = var.security_group_ids
  subnet_group_name    = var.subnet_group_name
  engine               = var.engine
  node_type            = var.node_type
  parameter_group_name = var.parameter_group_name
  engine_version       = var.engine_version
  port                 = var.port
  lifecycle {
    ignore_changes = ["number_cache_clusters"]
  }
}

