variable "route_table_id" {
  description = "The route table id"
}

variable "subnet_id_map" {
  description = "map of subnet ids to be associated"
  type = map(string)
}