resource "aws_route_table_association" "route_table_subnets_associations"{
  for_each = var.subnet_id_map
  subnet_id = each.value
  route_table_id = var.route_table_id
}