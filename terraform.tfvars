region                        = "us-east-1"
vpc_name                      = "dev_vpc"
vpc_cidr_range                = "10.0.0.0/16"
env_name                      = "dev"
public_subnet_cidr            = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_az              = ["us-east-1a", "us-east-1b"]
private_subnet_cidr_range     = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
private_subnet_az             = ["us-east-1a", "us-east-1b"]
ingress_rules                 = ["80", "22", "3306"]
web_template_name             = "web_tier"
app_template_name             = "App_tier"
lauch_template_ami            = "ami-04b4f1a9cf54c11d0"
launch_template_instance_type = "t2.micro"
key_name                      = "three-tier-key"

#rds
engine               = "mysql"
engine_version       = "8.0.40"
db_identifier        = "three-tier-db"
db_instance_type     = "db.t4g.micro"
db_allocated_storage = "20"
db_storage_type      = "gp2"
db_user              = "admin"
db_passwd            = "arun1234"

#bastion
instance_type_bastion = "t2.micro"
