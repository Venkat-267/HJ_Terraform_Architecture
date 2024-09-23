variable "aws_region" {
  description = "AWS region to deploy the resources"
  default     = "ap-south-1"
}


variable "vpc_name" {
  description = "VPC ID"
  default = "default-vpc"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances"
  default     = 2
}

variable "db_instance_class" {
  type        = string
  description = "The instance class of the RDS instance"
  default     = "db.t3.micro"
}

variable "rds_identifier" {
  type = string
  description = "RDS Identifier"
  default = "my-rds-db"
}

variable "alb_name" {
  type        = string
  description = "The name of the Application Load Balancer"
  default     = "my-alb"
}

