resource "aws_route_table" "subnet_route_table" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.cidr_gateway_id_map
    iterator = route
    content {
      cidr_block = route.key
      gateway_id = route.value
    }
  }

  tags = {
    Name = "${var.env}-${var.route_table_name}"
    env = var.env
  }
}