#web_tier

resource "aws_autoscaling_group" "webasg" {
  launch_template {
    id      = var.web_asgtemplate
    version = "$Latest"
  }

  min_size            = 2
  max_size            = 4
  desired_capacity    = 2
  vpc_zone_identifier = var.vpc_zone_identifier

  health_check_type         = "EC2"
  health_check_grace_period = 30

  target_group_arns = [var.web_target_group_arns]


}

#apptier asg

resource "aws_autoscaling_group" "appasg" {
  launch_template {
    id      = var.app_asgtemplate
    version = "$Latest"
  }

  min_size            = 2
  max_size            = 4
  desired_capacity    = 2
  vpc_zone_identifier = var.vpc_zone_identifier_app

  health_check_type         = "EC2"
  health_check_grace_period = 30

  target_group_arns = [var.app_target_group_arns]


}
