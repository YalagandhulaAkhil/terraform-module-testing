resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  force_destroy = true
}

output "s3_bucket_name" {
  value = aws_s3_bucket.this.id
}