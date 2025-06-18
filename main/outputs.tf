output "s3_bucket_name" {
  value = module.s3.s3_bucket_name
}

output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}

output "dynamodb_table_name" {
  value = module.dynamodb.dynamodb_table_name
}
