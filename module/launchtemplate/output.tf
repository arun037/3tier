output "web_tier_template" {
  value = aws_launch_template.web_template.id
}

output "app_tier_template" {
  value = aws_launch_template.app_template.id
}
