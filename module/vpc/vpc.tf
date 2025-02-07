provider "aws" {
  region = var.region_name

}

resource "aws_vpc" "myvpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = var.vpc_name
    environment = var.env

  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name        = "${var.vpc_name}-IGw"
    environment = var.env
  }
}

