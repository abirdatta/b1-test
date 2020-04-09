resource "aws_eip" "elastic_ip" {
  vpc = true
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = var.subnet_id

  tags = {
    Name = var.name
    env = var.env
  }
}
