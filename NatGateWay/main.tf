provider "aws"{
region = var.region
}
# Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eips" {
  count = length(var.public_subnet_ids)
}

# NAT Gateways
resource "aws_nat_gateway" "nat_gateways" {
  count         = length(var.public_subnet_ids)
  allocation_id = aws_eip.nat_eips[count.index].id
  subnet_id     = var.public_subnet_ids[count.index]
}

# Private Route Tables
resource "aws_route_table" "private_rts" {
  count  = length(var.private_subnet_ids)
  vpc_id = var.vpc_id
}

# Routes for Private Subnets
resource "aws_route" "private_routes" {
  count                  = length(var.private_subnet_ids)
  route_table_id         = aws_route_table.private_rts[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateways[count.index].id
}

# Associate Private Subnets with Route Tables
resource "aws_route_table_association" "private_assocs" {
  count         = length(var.private_subnet_ids)
  subnet_id     = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private_rts[count.index].id
}
