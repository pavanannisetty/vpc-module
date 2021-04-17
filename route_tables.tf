 # Public Route Table

resource "aws_route_table" "public_route" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "${var.environment}_Public_RT"
  }
}

 # Private Route Table

resource "aws_default_route_table" "private_route" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat.id}"
  }

  tags = {
    Name = "${var.environment}_Private_RT"
  }
}

 #Associate Public Subnet with Public Route Table

resource "aws_route_table_association" "public_subnet_assoc" {
  count          = length(split(",", var.public_subnets))
  route_table_id = element(aws_route_table.public_route.*.id, count.index)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
}


#Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = length(split(",", var.private_subnets))
  route_table_id = element(aws_default_route_table.private_route.*.id, count.index)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
}

