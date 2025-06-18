variable "dynamodb_table_name" {
  type        = string
  description = "Name of the DynamoDB table"
}

variable "dynamodb_hash_key" {
  type        = string
  description = "Primary hash key for the table"
}

variable "dynamodb_hash_key_type" {
  type        = string
  description = "Data type of the hash key (e.g., S or N)"
}

variable "environment" {
  type        = string
  description = "Environment tag"
}
