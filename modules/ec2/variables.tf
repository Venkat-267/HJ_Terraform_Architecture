variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = list(string)
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}

variable "security_group" {
  description = "Security group for the EC2 instances"
}
