output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  value = var.vpc_cidr_block
}

output "vpc_subnet_group" {
  value = aws_subnet.public_subnets[0]
}