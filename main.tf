module "s3" {
  source      = "../modules/s3"
  bucket_name = var.bucket_name
}

module "dynamodb" {
  source     = "../modules/dynamodb"
  table_name = var.dynamodb_table_name
  hash_key   = var.dynamodb_hash_key
}

module "lambda" {
  source        = "../modules/lambda"
  function_name = var.lambda_function_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  filename      = var.lambda_zip
}
