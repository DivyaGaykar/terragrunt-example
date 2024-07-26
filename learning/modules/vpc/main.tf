# Define a vpc
resource "aws_vpc" "vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "my-test-vpc"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.1.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "my-test-pri-sub"
  }
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = "subnet-0ee487648c3919d69"

  tags = {
    Name = "test-nat"
  }
}

# Private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name      = "pri_rtb"
  }
}

resource "aws_route_table_association" "private" {
  depends_on     = [aws_subnet.private_subnet_a]
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_a.id
}
