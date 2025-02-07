output "external_lb_targetgrp_arn" {
  value = aws_lb_target_group.mytarget.id
}

output "internal_lb_targetgrp_arn" {
  value = aws_lb_target_group.internal-tg.id
}