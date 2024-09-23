output "ec2_instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.ec2_instance_public_ips
}

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = module.rds.endpoint
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.my_bucket.id
}

# Output the VPC Endpoint ID
output "s3_vpc_endpoint_id" {
  description = "The ID of the VPC endpoint for S3"
  value       = aws_vpc_endpoint.s3_vpc_endpoint.id
}