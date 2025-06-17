terraform {
  backend "s3" {
    bucket         = "tf-demo-bucket-2025"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-lock-table"
    encrypt        = true
  }
}