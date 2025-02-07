provider "aws" {
  region = "us-east-1"

}

module "vpc" {
  source                          = "./module/vpc"
  region_name                     = "us-east-1"
  vpc_name                        = "dev_vpc"
  vpc_cidr                        = "10.0.0.0/16"
  env                             = "dev"
  public_subnet_cidr              = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_available_region  = ["us-east-1a", "us-east-1b"]
  private_subnet_cidr             = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
  private_subnet_available_region = ["us-east-1a", "us-east-1b", "us-east-1a", "us-east-1b", "us-east-1a", "us-east-1b"]
}

module "security_group" {
  source        = "./module/sg"
  sg_vpc_id     = module.vpc.vpc_id
  vpc_name      = module.vpc.vpc_name
  ingress_rules = ["80", "22", "443", "3306"]
}

module "loadbalance" {
  source              = "./module/lb"
  vpc_id              = module.vpc.vpc_id
  external_lb_sg      = module.security_group.external_lb_sg.id
  external_lb_subnets = module.vpc.public_subnet.id
  internal_lb_sg      = module.security_group.internal_lb_sg.id
  internal_lb_subnets = module.vpc.apptier_subnets.id
}

module "launchtemplate" {
  source                      = "./module/launchtemplate"
  webtier_lauch_template_name = "webtier_template"
  webtier_image_id            = "ami-04b4f1a9cf54c11d0"
  webtier_instance_type       = "t2.micro"
  key_name                    = "us-east-key.pem"
  webtier_subnetid            = module.vpc.webtier_subnets.id
  webtier_sg_id               = module.security_group.webtier_sg.id
  apptier_lauch_template_name = "apptier_template"
  apptier_subnetid            = module.vpc.apptier_subnets.id
  apptier_sg_id               = module.security_group.apptier_sg.id
}

module "asg" {
  source                  = "./module/asg"
  web_asgtemplate         = module.launchtemplate.web_tier_template.id
  vpc_zone_identifier     = module.vpc.webtier_subnets.id
  web_target_group_arns   = module.loadbalance.external_lb_targetgrp_arn
  app_asgtemplate         = module.launchtemplate.app_tier_template.id
  app_target_group_arns   = module.loadbalance.internal_lb_targetgrp_arn
  vpc_zone_identifier_app = module.vpc.apptier_subnets.id
}
