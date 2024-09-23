variable "vpc_id" {
  description = "ID of the VPC where the S3 bucket's VPC endpoint will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the S3 VPC endpoint will be deployed"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs for the S3 VPC endpoint"
  type        = list(string)
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}
