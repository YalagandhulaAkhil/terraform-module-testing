aws_region           = "us-east-1"

s3_bucket_name       = "my-modularized-s3-bucket"

dynamodb_table_name  = "MyAppData"
dynamodb_hash_key    = "id"
dynamodb_hash_key_type = "S"

lambda_function_name = "MyLambdaFunction"
lambda_handler        = "lambda_function.lambda_handler"
lambda_runtime        = "python3.9"
lambda_zip_path       = "modules/lambda/lambda_function.zip"
