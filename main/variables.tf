variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# S3 Variables
variable "s3_bucket_name" {
  description = "Name of the S3 bucket to be created"
  type        = string
}

# DynamoDB Variables
variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "dynamodb_hash_key" {
  description = "Primary hash key for the DynamoDB table"
  type        = string
}

variable "dynamodb_hash_key_type" {
  description = "Type of the primary hash key (e.g., S for String)"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g., dev, prod)"
  type        = string
}
