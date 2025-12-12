output "app_bucket_name" {
  value = aws_s3_bucket.app.bucket
}

output "logs_bucket_name" {
  value = aws_s3_bucket.logs.bucket
}

output "app_bucket_arn" {
  value = aws_s3_bucket.app.arn
}

output "logs_bucket_arn" {
  value = aws_s3_bucket.logs.arn
}
