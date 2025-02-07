resource "aws_subnet" "public_subnet" {
  count             = 2
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.public_subnet_available_region, count.index)

  tags = {
    Name        = "${var.vpc_name}-Public_sub-${count.index + 1}"
    environment = var.env
  }

}

resource "aws_subnet" "private_subnet" {
  count             = 6
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.private_subnet_available_region, count.index)

  tags = {
    Name        = "${var.vpc_name}-Private_sub-${count.index + 1}"
    environment = var.env
  }

}
