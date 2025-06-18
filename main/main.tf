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

module "lambda" {
  source              = "./modules/lambda"
  function_name       = var.lambda_function_name
  handler             = var.lambda_handler
  runtime             = var.lambda_runtime
  source_path         = var.lambda_source_path
  role_name           = var.lambda_role_name
}

module "dynamodb" {
  source         = "./modules/dynamodb"
  dynamodb_table = var.dynamodb_table_name
}