resource "aws_kinesis_stream" "stock_stream" {
  name        = var.stream_name
  shard_count = var.shard_count
  retention_period = 24
}

variable "stream_name" {}
variable "shard_count" {}
