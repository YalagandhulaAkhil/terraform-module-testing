provider "aws" {
  region = var.aws_region
}

# S3 Bucket Module
module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

# DynamoDB Module
module "dynamodb" {
  source       = "./modules/dynamodb"
  table_name   = var.dynamodb_table_name
  hash_key     = var.dynamodb_hash_key
  hash_key_type = var.dynamodb_hash_key_type
}

# IAM Role for Lambda Execution
data "aws_iam_policy_document" "lambda_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name               = "lambda_exec_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_trust.json
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Function Module
module "lambda" {
  source        = "./modules/lambda"
  function_name = var.lambda_function_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  role_arn      = aws_iam_role.lambda_exec.arn
  filename      = var.lambda_zip_path
}
