terraform {
  backend "s3" {
    bucket         = "my-terraform-backend-venkat" 
    key            = "global/s3/terraform.tfstate"
    region         = "ap-south-1"                   
    dynamodb_table = "my-terraform-backend-rds"
    encrypt        = true          
  }
}
