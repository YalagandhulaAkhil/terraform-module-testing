output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "lambda_function_name" {
  value = module.lambda.lambda_name
}
