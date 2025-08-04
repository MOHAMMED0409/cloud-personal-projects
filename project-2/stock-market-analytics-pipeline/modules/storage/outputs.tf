output "dynamodb_table_name" {
  value = aws_dynamodb_table.stock_data.name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.raw_stock.id
}
