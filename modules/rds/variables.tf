variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = list(string)
}

variable "db_instance_class" {
  description = "The class of the RDS instance"
  type        = string
}

variable "security_group" {
  description = "Security group for the RDS instance"
}

variable "rds_identifier" {
  description = "RDS Identifier"
}