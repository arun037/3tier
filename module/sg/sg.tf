#1.bastionsg

resource "aws_security_group" "bastion_sg" {
  description = "bastion_security group"
  vpc_id      = var.sg_vpc_id

  tags = {
    Name = "${var.vpc_name}-bastion_sg"

  }

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

#2.external lb
resource "aws_security_group" "external_lb" {
  description = "external loadbalancer sg"
  vpc_id      = var.sg_vpc_id

  tags = {
    Name = "${var.vpc_name}-lb_sg"

  }

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

#3.webtier_sg
resource "aws_security_group" "webtier_sg" {
  vpc_id      = var.sg_vpc_id
  description = "allow traffic from externallb sg and bastion"

  tags = {
    Name = "${var.vpc_name}-webtier_sg"

  }

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description     = ingress.value
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.external_lb.id, aws_security_group.bastion_sg.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

#4.internal lb
resource "aws_security_group" "internal_lbsg" {
  description = "internal_loadbalancer sg"
  vpc_id      = var.sg_vpc_id

  tags = {
    Name = "${var.vpc_name}-internalb_sg"

  }

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.webtier_sg.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

#5.apptier sg
resource "aws_security_group" "apptier_sg" {
  vpc_id      = var.sg_vpc_id
  description = "allow traffic from internallb sg and bastion"

  tags = {
    Name = "${var.vpc_name}-apptier_sg"

  }

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description     = ingress.value
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.internal_lbsg.id, aws_security_group.bastion_sg.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

#6.rds_sg

resource "aws_security_group" "rds_sg" {
  vpc_id      = var.sg_vpc_id
  description = "allow traffic from Apptier"

  tags = {
    Name = "${var.vpc_name}-rds_sg"

  }

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description     = ingress.value
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.apptier_sg.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

