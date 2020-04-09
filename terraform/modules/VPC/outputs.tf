output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_arn" {
  value = aws_vpc.vpc.arn
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}