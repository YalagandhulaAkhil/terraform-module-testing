output "s3_bucket_name" {
  value = module.s3.s3_bucket_name
}

output "created_dynamodb_table_name" {
  value = module.dynamodb_table_example.dynamodb_table_name
}
