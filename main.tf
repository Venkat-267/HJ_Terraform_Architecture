data "aws_vpc" "main_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]  # Replace <vpc-name> with your VPC name
  }
}

# Fetch all subnets in the VPC
data "aws_subnets" "main_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main_vpc.id]
  }
}

# Fetch route tables associated with the VPC
data "aws_route_tables" "main_route_tables" {
  vpc_id = data.aws_vpc.main_vpc.id
}


# Security group for all instances
resource "aws_security_group" "app_sg" {
  name        = "app_security_group"
  description = "Security group for EC2 instances, RDS, and ALB"
  vpc_id      = data.aws_vpc.main_vpc.id

  # Allow inbound HTTP for ALB/EC2
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH from your IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with your IP address or use a variable
  }

  # Allow outbound traffic (default)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "AppSecurityGroup"
    Environment = "Development"
  }
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = data.aws_vpc.main_vpc.id
  subnet_ids = data.aws_subnets.main_subnets.ids
  instance_count = var.instance_count
  security_group = aws_security_group.app_sg.id
}

module "rds" {
  source = "./modules/rds"
  vpc_id = data.aws_vpc.main_vpc.id
  subnet_ids = data.aws_subnets.main_subnets.ids
  security_group = aws_security_group.app_sg.id
  db_instance_class = var.db_instance_class
  rds_identifier = var.rds_identifier
  
}

module "alb" {
  source           = "./modules/alb"
  vpc_id           = data.aws_vpc.main_vpc.id
  subnet_ids       = data.aws_subnets.main_subnets.ids
  security_group   = aws_security_group.app_sg.id
  alb_name         = var.alb_name
}


