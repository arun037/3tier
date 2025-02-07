output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "public_subnet" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet" {
  value = aws_subnet.private_subnet[*].id
}

output "webtier_subnets" {
  value = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]
}

output "apptier_subnets" {
  value = [aws_subnet.private_subnet[2].id, aws_subnet.private_subnet[3].id]
}

output "db_subnet" {
  value = [aws_subnet.private_subnet[4].id, aws_subnet.private_subnet[5].id]
}

output "env" {
  value = var.env
}

output "region_name" {
  value = var.region_name
}

output "vpc_name" {
  value = var.vpc_name
}
