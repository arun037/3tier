#target group creation
resource "aws_lb_target_group" "mytarget" {
  name     = "TargetGroup-01"
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
resource "aws_lb" "alb" {
  name               = "externalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.external_lb_sg]
  subnets            = var.external_lb_subnets

}

#listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mytarget.arn
  }

}
