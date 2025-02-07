variable "region" {}
variable "vpc_name" {}
variable "vpc_cidr_range" {}
variable "env_name" {}
variable "public_subnet_cidr" {}
variable "public_subnet_az" {}
variable "private_subnet_cidr_range" {}
variable "private_subnet_az" {}
variable "ingress_rules" {}
variable "web_template_name" {}
variable "app_template_name" {}
variable "lauch_template_ami" {}
variable "launch_template_instance_type" {}
variable "key_name" {}

#rds
variable "engine" {}
variable "engine_version" {}
variable "db_identifier" {}
variable "db_instance_type" {}
variable "db_allocated_storage" {}
variable "db_storage_type" {}
variable "db_user" {}
variable "db_passwd" {}

#bastion
variable "instance_type_bastion" {}