# Define a vpc
resource "aws_vpc" "vpc" {
  cidr_block = "10.5.0.0/16"
  tags = {
    Name = "${var.prefix}-vpc"
    createdBy = "infra-${var.prefix}/base"
  }
}

/*
resource "aws_ssm_parameter" "vpc" {
  name = "/${var.prefix}/base/vpc_id"
  value = "${aws_vpc.vpc.id}"
  type  = "String"
}
*/

# Routing table for public subnets
resource "aws_route_table" "public_subnet_routes" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags = {
    Name = "${var.prefix} Public subnet routing table"
    createdBy = "infra-${var.prefix}/base"
  }
}

# Internet gateway for the public subnet
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "${var.prefix} Public gateway"
    createdBy = "infra-${var.prefix}/base"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.5.0.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.prefix} Public subnet A"
    createdBy = "infra-${var.prefix}/base"
  }
}

/*
resource "aws_ssm_parameter" "subnet_a" {
  name = "/${var.prefix}/base/subnet/a/id"
  value = "${aws_subnet.public_subnet_a.id}"
  type  = "String"
}
*/

resource "aws_subnet" "public_subnet_b" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.5.1.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.prefix} Public subnet B"
    createdBy = "infra-${var.prefix}/base"
  }
}

/*
resource "aws_ssm_parameter" "subnet_b" {
  name = "/${var.prefix}/base/subnet/b/id"
  value = "${aws_subnet.public_subnet_b.id}"
  type  = "String"
}
*/

# Here, you can add more subnets in other availability zones

# Associate the routing table to public subnet A
resource "aws_route_table_association" "public_subnet_routes_assn_a" {
  subnet_id = "${aws_subnet.public_subnet_a.id}"
  route_table_id = "${aws_route_table.public_subnet_routes.id}"
}

# Associate the routing table to public subnet B
resource "aws_route_table_association" "public_subnet_routes_assn_b" {
  subnet_id = "${aws_subnet.public_subnet_b.id}"
  route_table_id = "${aws_route_table.public_subnet_routes.id}"
}

output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_a" {
  value = aws_subnet.public_subnet_a.id
}

output "public_subnet_b" {
  value = aws_subnet.public_subnet_b.id
}