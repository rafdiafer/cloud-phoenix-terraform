output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "public_cidrs" {
  value = aws_subnet.public_subnet.*.cidr_block
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
}

output "nat_gw" {
  value = aws_nat_gateway.nat_gw.id
}

output "public_azs" {
  value = aws_subnet.public_subnet.*.availability_zone
}

output "private_azs" {
  value = aws_subnet.private_subnet.*.availability_zone
}