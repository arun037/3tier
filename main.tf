provider "aws" {
  region = var.region

}

module "vpc" {
  source                         = "./module/vpc"
  region_name                    = var.region
  vpc_name                       = var.vpc_name
  vpc_cidr                       = var.vpc_cidr_range
  env                            = var.env_name
  public_subnet_cidr             = var.public_subnet_cidr
  public_subnet_available_region = var.public_subnet_az
  private_subnet_cidr            = var.private_subnet_cidr_range
  private_subnet_azs             = var.private_subnet_az
}

module "security_group" {
  source        = "./module/sg"
  sg_vpc_id     = module.vpc.vpc_id
  vpc_name      = module.vpc.vpc_name
  ingress_rules = var.ingress_rules
}

module "loadbalance" {
  source              = "./module/lb"
  vpc_id              = module.vpc.vpc_id
  external_lb_sg      = module.security_group.external_lb_sg
  external_lb_subnets = module.vpc.public_subnet[*]
  internal_lb_sg      = module.security_group.internal_lb_sg
  internal_lb_subnets = module.vpc.apptier_subnets[*]
}

module "launchtemplate" {
  source                      = "./module/launchtemplate"
  webtier_lauch_template_name = var.web_template_name
  webtier_image_id            = var.lauch_template_ami
  webtier_instance_type       = var.launch_template_instance_type
  key_name                    = var.key_name
  webtier_subnetid            = module.vpc.webtier_subnets[*]
  webtier_sg_id               = module.security_group.webtier_sg
  apptier_lauch_template_name = var.app_template_name
  apptier_subnetid            = module.vpc.apptier_subnets[*]
  apptier_sg_id               = module.security_group.apptier_sg
}

module "asg" {
  source                  = "./module/asg"
  web_asgtemplate         = module.launchtemplate.web_tier_template
  vpc_zone_identifier     = module.vpc.webtier_subnets[*]
  web_target_group_arns   = module.loadbalance.external_lb_targetgrp_arn
  app_asgtemplate         = module.launchtemplate.app_tier_template
  app_target_group_arns   = module.loadbalance.internal_lb_targetgrp_arn
  vpc_zone_identifier_app = module.vpc.apptier_subnets[*]
}

module "rds" {
  source               = "./module/rds"
  rds_subnet           = module.vpc.db_subnet[*]
  engine               = var.engine
  engine_version       = var.engine_version
  db_identifier        = var.db_identifier
  db_instance_type     = var.db_instance_type
  db_allocated_storage = var.db_allocated_storage
  db_storage_type      = var.db_storage_type
  db_username          = var.db_user
  db_password          = var.db_passwd
  db_securitygroup_id  = module.security_group.rds_sg
}

resource "aws_instance" "bastion" {
  ami             = var.lauch_template_ami
  instance_type   = var.instance_type_bastion
  key_name        = var.key_name
  security_groups = [module.security_group.bastion_sg]
  subnet_id       = module.vpc.public_subnet[0]
}
