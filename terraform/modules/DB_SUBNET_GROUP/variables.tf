variable "subnet_group_name" {
  description = "DB Subnet Group Name"
}

variable "description" {
  default = "DB Subnet Group"
}

variable "subnet_ids" {
  description = "list of subnet ids"
  type = list(string)
}

variable "tag_name" {}

variable "env" {}