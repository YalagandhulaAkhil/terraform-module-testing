variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "filename" {
  description = "Path to the Lambda deployment package (ZIP file)"
  type        = string
}

variable "role_name" {
  description = "IAM Role name for Lambda execution"
  type        = string
}
