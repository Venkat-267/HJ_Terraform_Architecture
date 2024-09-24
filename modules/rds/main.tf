resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = var.db_instance_class
  db_name                 = "mydbterraform"
  identifier = var.rds_identifier
  username             = "admin"
  password             = "admin123"
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = false
  vpc_security_group_ids = [var.security_group]
  skip_final_snapshot  = true

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group2"
  subnet_ids = var.subnet_ids
}

output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}
