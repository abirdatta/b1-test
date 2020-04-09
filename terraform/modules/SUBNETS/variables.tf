variable "zones_cidr_map" {
  description = "AWS availability zones"
  type = map(string)
}

variable "vpc_id" {
  description = "VPC Id for the subnets"
}

variable "region" {
  description = "Region for the subnets"
}

variable "subnet_name_prefix" {
  description = "subnet name prefix like compute-private, db-private etc."
}

variable "env" {
  description = "Environment dev staging or prod"
}

variable "map_public_ip_on_launch" {
  type = bool
  description = "Map Public IP on launch"
  default = false
}