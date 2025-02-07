output "external_lb_targetgrp_arn" {
  value = aws_lb_target_group.mytarget.id
}

output "internal_lb_targetgrp_arn" {
  value = aws_lb_target_group.internal-tg.id
}

output "external_lb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "internal_lb_dns_name" {
  value = aws_lb.alb_internal.dns_name
}
