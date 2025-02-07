resource "aws_launch_template" "app_template" {
  name          = var.apptier_lauch_template_name
  image_id      = var.webtier_image_id
  instance_type = var.webtier_instance_type

  key_name = var.key_name

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
    associate_public_ip_address = false
    #subnet_id                   = var.apptier_subnetid
    security_groups = [var.apptier_sg_id]
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "App_instance"
    }
  }


}
