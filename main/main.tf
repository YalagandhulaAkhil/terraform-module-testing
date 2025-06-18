terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

module "dynamodb" {
  source                  = "./modules/dynamodb"
  dynamodb_table_name     = var.dynamodb_table_name
  dynamodb_hash_key       = var.dynamodb_hash_key
  dynamodb_hash_key_type  = var.dynamodb_hash_key_type
  environment             = var.environment
}
