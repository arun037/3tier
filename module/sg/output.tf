output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
}

output "external_lb_sg" {
  value = aws_security_group.external_lb.id
}

output "webtier_sg" {
  value = aws_security_group.webtier_sg.id
}

output "internal_lb_sg" {
  value = aws_security_group.internal_lbsg.id
}

output "apptier_sg" {
  value = aws_security_group.apptier_sg.id

}

output "rds_sg" {
  value = aws_security_group.rds_sg.id
}
