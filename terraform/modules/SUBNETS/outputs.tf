output "subnet_ids" {
  value = [for subnet in aws_subnet.subnets: subnet.id]
}

output "subnet_cidrs" {
  value = [for subnet in aws_subnet.subnets: subnet.cidr_block]
}

output "az" {
  value = [for subnet in aws_subnet.subnets: subnet.availability_zone]
}

output "az_subnet_id_map" {
  value = {
    for subnet in aws_subnet.subnets:
    subnet.availability_zone => subnet.id
  }
}