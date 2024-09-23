terraform {
  backend "s3" {
    bucket         = var.aws_backend_s3  
    key            = "global/s3/terraform.tfstate"
    region         = var.aws_region                    
    dynamodb_table = var.aws_backend_rds
    encrypt        = true          
  }
}
