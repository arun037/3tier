#target group creation
resource "aws_lb_target_group" "internal-tg" {
  name     = "TargetGroup-Internal"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

}

#loadbalancer creation:
resource "aws_lb" "alb_internal" {
  name               = "internallb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.internal_lb_sg]
  subnets            = var.internal_lb_subnets

}

#listene
resource "aws_lb_listener" "internal_listener" {
  load_balancer_arn = aws_lb.alb_internal.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal-tg.arn
  }

}
