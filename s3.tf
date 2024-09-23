# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-private-bucket-venkat"  # Replace with a unique bucket name

  tags = {
    Name        = "MyPrivateS3Bucket"
    Environment = "Development"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}

# Create a VPC Endpoint for S3 (Gateway Endpoint)
resource "aws_vpc_endpoint" "s3_vpc_endpoint" {
  vpc_id       = data.aws_vpc.main_vpc.id
  service_name = "com.amazonaws.${var.aws_region}.s3"

  route_table_ids = data.aws_route_tables.main_route_tables.ids  # Ensure you have this data source defined

  tags = {
    Name = "S3-VPC-Endpoint"
  }
}

# Define a bucket policy to restrict access
resource "aws_s3_bucket_policy" "s3_private_access" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource  = [
          "${aws_s3_bucket.my_bucket.arn}/*"
        ]
        Condition = {
          StringNotEquals = {
            "aws:sourceVpce" = aws_vpc_endpoint.s3_vpc_endpoint.id
          }
        }
      }
    ]
  })
}
