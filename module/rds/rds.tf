resource "aws_db_subnet_group" "default" {
  name       = "db_subnet"
  subnet_ids = var.rds_subnet

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_db_instance" "mydb" {
  engine                 = var.engine
  engine_version         = var.engine_version
  identifier             = var.db_identifier
  instance_class         = var.db_instance_type
  allocated_storage      = var.db_allocated_storage
  storage_type           = var.db_storage_type
  username               = var.db_username
  password               = var.db_password
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [var.db_securitygroup_id]
  skip_final_snapshot    = true

}
