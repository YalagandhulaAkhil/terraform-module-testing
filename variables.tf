variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
}

variable "dynamodb_hash_key" {
  description = "Primary hash key for DynamoDB table"
  type        = string
}

variable "dynamodb_hash_key_type" {
  description = "Type of hash key (S, N, B)"
  type        = string
  default     = "S"
}

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

variable "lambda_zip_path" {
  description = "Path to Lambda zip file"
  type        = string
}
