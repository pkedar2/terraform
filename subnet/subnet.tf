#public Subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet1"
  }
}
#private subnet
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "PrivateSubnet2"
  }
}
