output "bastion_ip" {
  value = aws_instance.bastion.public_ip
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "external_lb_endpoint" {
  value = module.loadbalance.external_lb_dns_name
}

output "internal_lb_endpoint" {
  value = module.loadbalance.internal_lb_dns_name
}
