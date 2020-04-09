variable "cidr_gateway_id_map" {
  description = "Map of CIDR and GatewayIds"
  type = map(string)
}

variable "vpc_id" {
  description = "VPC Id for the subnets"
}

variable "route_table_name" {
  description = "Route Table name"
}

variable "env" {
  description = "Environment dev staging or prod"
}