# Creating NAT Gateway

resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${element(aws_subnet.public_subnets.*.id, 0)}"
  depends_on    = [aws_internet_gateway.gw]

  tags = {
    Name        = "${var.environment}_NAT"
  }
}
