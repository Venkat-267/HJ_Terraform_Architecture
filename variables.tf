variable "aws_region" {
  description = "AWS region to deploy the resources"
  default     = "ap-south-1"
}

variable "aws_backend_s3" {
  description = "AWS S3 Bucket for Backend"
  default = "my-terraform-backend-venkat"
}

variable "aws_backend_rds" {
  description = "value"
  default = ""
}

variable "vpc_name" {
  description = "VPC ID"
  default = "default-vpc"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances"
  default     = 1
}

variable "db_instance_class" {
  type        = string
  description = "The instance class of the RDS instance"
  default     = "db.t3.micro"
}

variable "alb_name" {
  type        = string
  description = "The name of the Application Load Balancer"
  default     = "my-alb"
}

