resource "aws_launch_template" "web_template" {
  name          = var.webtier_lauch_template_name
  image_id      = var.webtier_image_id
  instance_type = var.webtier_instance_type
  key_name      = var.key_name

  user_data = base64encode(<<-EOF
    #!/bin/bash -xe
    exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
    apt-get update -y
    apt-get install -y apache2
    systemctl start apache2
    systemctl enable apache2
    echo "<h1>Hello from EC2 $(uname -n) </h1>" > /var/www/html/index.html
    EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.webtier_subnetid
    security_groups             = var.webtier_sg_id
  }

  monitoring {
    enabled = true
  }
}
