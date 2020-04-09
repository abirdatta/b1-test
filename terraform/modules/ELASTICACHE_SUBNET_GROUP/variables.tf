variable "subnet_group_name" {
  description = "Elasticache Subnet Group Name"
}

variable "description" {
  default = "Elasticache Subnet Group"
}

variable "subnet_ids" {
  description = "list of subnet ids"
  type = list(string)
}
