variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = list(string)
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}

variable "security_group" {
  description = "Security group for the ALB"
}
