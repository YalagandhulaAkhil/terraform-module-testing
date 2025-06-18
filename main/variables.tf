variable "aws_region" {
  default = "us-east-1"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to be created"
  type        = string
}
