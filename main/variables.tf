variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
}

# S3
variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

# Lambda
variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
}
variable "lambda_handler" {
  description = "Lambda handler"
  type        = string
}
variable "lambda_runtime" {
  description = "Lambda runtime"
  type        = string
}
variable "lambda_source_path" {
  description = "Path to lambda zip file"
  type        = string
}
variable "lambda_role_name" {
  description = "IAM role name for Lambda"
  type        = string
}

# DynamoDB
variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}
