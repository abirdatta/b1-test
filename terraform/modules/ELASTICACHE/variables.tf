variable "engine" {
  description = "Engine of Elasticache cluster, memcached or redis"
  default = "redis"
}
variable "node_type" {
  description = "Node Instance type"
}

variable "parameter_group_name" {
  description = "Parameter group name"
}
variable "engine_version" {
  description = "Engine version of elasticache engine"
}
variable "port" {
  description = "port value of engine"
}
variable "maintenance_window" {
  default = "mon:00:00-mon:03:00"
}
variable "security_group_ids" {
  type = list(string)
  description = "security group ids to be associated"
}
variable "subnet_group_name" {
  description = "Elasticache Subnet Group name"
}

variable "az" {
  type = list(string)
  description = "Availabililty Zones"
}

variable "replication_group_id" {
  description = "Resplication Group Id"
}

variable "replication_group_description" {
  description = "Resplication Group Desc"
}

variable "number_cache_clusters" {
  description = "(Required for Cluster Mode Disabled) The number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. "
}

variable "tags" {
  type = map(string)
}

variable "automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. Must be enabled for Redis (cluster mode enabled) replication groups. Defaults to false"
  type = bool
}