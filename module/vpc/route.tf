resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    name = "${var.vpc_name}-pub_rt"
  }

}

resource "aws_route_table_association" "pub_association" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gate.id
  }

  tags = {
    Name = "${var.vpc_name}-Private_rt"
  }

}

resource "aws_route_table_association" "pri_asso" {
  count          = 6
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route.id

}
