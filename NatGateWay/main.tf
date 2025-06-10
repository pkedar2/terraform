provider "aws" "test"{
region = "ap-south-1"
}
resource "aws_eip" "ngw_elesticip_1" {}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.ngw_elesticip_1.id
  subnet_id     = aws_subnet.public_subnet_1.id  
}
resource "aws_route_table" "private_rt_1" {
  vpc_id = aws_vpc.test.id
}
resource "aws_route" "private_ngw_route" {
  route_table_id         = aws_route_table.private_rt_1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_eip" "ngw_elesticip_2" {}
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.ngw_elesticip_2.id
  subnet_id     = aws_subnet.public_subnet_2.id  
}
resource "aws_route_table" "private_rt_2" {
  vpc_id = aws_vpc.test.id
}
resource "aws_route" "private_ngw_route" {
  route_table_id         = aws_route_table.private_rt_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}
