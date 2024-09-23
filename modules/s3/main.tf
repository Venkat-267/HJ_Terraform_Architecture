resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  subnet_ids        = var.subnet_ids
  security_group_ids = var.security_group_ids

  tags = {
    Name = "S3 VPC Endpoint"
  }
}

output "bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}

output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.s3_endpoint.id
}
