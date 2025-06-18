variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default = "us-east-1"
}

# S3
variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default = "tf-new-demo-bucket-2026666"
}

# Lambda
variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
  default = "myLambdaFunction"
}
variable "lambda_handler" {
  description = "Lambda handler"
  type        = string
  default = "values.handler"
}
variable "lambda_runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "nodejs18.x"
}
variable "lambda_source_path" {
  description = "Path to lambda zip file"
  type        = string
  default = "./modules/lambda/lambda_function.zip"
}
variable "lambda_role_name" {
  description = "IAM role name for Lambda"
  type        = string
  default = "myLambdaFunction_role"
}

# DynamoDB
variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default = "tf-new-table-2026666"
}
