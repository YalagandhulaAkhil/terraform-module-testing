aws_region           = "us-east-1"

# S3
s3_bucket_name       = "tf-demo-bucket-2025"

# Lambda
lambda_function_name = "myLambdaFunction"
lambda_handler       = "index.handler"
lambda_runtime       = "nodejs18.x"
lambda_source_path   = "lambda_function.zip"
lambda_role_name     = "myLambdaFunction_role"

# DynamoDB
dynamodb_table_name  = "tf-lock-table"
