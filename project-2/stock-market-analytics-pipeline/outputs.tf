output "dynamodb_table" {
  value = module.storage.dynamodb_table_name
}

output "kinesis_stream" {
  value = module.kinesis.stream_name
}