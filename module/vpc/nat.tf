resource "aws_eip" "elastic_ip" {
  tags = {
    Name = "${var.vpc_name}-eip"
  }

}

resource "aws_nat_gateway" "nat_gate" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "${var.vpc_name}-nat"
  }

  depends_on = [aws_eip.elastic_ip]

}

