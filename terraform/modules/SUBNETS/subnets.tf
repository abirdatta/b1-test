resource "aws_subnet" "subnets" {
  for_each = var.zones_cidr_map
  vpc_id = var.vpc_id
  availability_zone = "${var.region}${each.key}"
  cidr_block = each.value
  tags = {
    Name = "${var.env}-${var.subnet_name_prefix}-${each.key}"
    env = var.env
  }
  map_public_ip_on_launch = var.map_public_ip_on_launch
}