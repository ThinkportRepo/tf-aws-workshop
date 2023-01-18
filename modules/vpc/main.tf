resource "aws_vpc" "vpc" {

  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
    environment= "dev"
  }
}

resource "aws_subnet" "public_subnets" {
  depends_on = [aws_vpc.vpc]

  count             = length(var.availability_zones)
  availability_zone = element(var.availability_zones, count.index)
  cidr_block = cidrsubnet(
    var.public_subnets_cidr_range
    , var.public_subnet_cidr_block_size
    , count.index
  )
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-public-subnet-${element(var.availability_zones, count.index)}"
    Type = "Public"
    environment= "dev"
  }

}