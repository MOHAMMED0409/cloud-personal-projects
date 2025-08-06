variable "aws_region" {
  default = "us-east-1"
}

variable "alpha_vantage_api_key" {}

variable "stream_name" {
  default = "stock-stream"
}

variable "stock_symbols" {
  type    = list(string)
  default = ["AAPL", "GOOGL"]
}
variable "bucket_name" {
  default = "stock-data-bucket-demo-khashif"
}
