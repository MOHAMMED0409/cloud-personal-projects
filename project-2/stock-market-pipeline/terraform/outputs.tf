output "s3_raw_bucket" {
  value = aws_s3_bucket.raw.bucket
}

output "athena_bucket" {
  value = aws_s3_bucket.athena_results.bucket
}

output "sns_topic" {
  value = aws_sns_topic.stock_alerts.arn
}
