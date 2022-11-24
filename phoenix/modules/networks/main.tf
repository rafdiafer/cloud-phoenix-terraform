resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "Service VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, count.index + 8)
  count             = length(var.aws_az)
  availability_zone = element(var.aws_az, count.index)
  tags = {
    Name = "Public Subnet ${element(var.aws_az, count.index)}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, count.index + 12)
  count             = length(var.aws_az)
  availability_zone = element(var.aws_az, count.index)

  tags = {
    Name = "Private Subnet ${element(var.aws_az, count.index)}"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "public_association" {
  count          = length(var.aws_az)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_vpc.vpc.main_route_table_id
}

resource "aws_route_table_association" "privanote_association" {
  count          = length(var.aws_az)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Internet GW"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnet.0.id
}

resource "aws_eip" "nat_gw_eip" {}