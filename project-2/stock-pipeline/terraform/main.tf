provider "aws" {
  region = var.aws_region
}

module "kinesis_stream" {
  source         = "./modules/kinesis_stream"
  stream_name    = var.stream_name
  shard_count    = 1
}

module "lambda_fetcher" {
  source                = "./modules/lambda_fetcher"
  stream_name           = var.stream_name
  alpha_vantage_api_key = var.alpha_vantage_api_key
  stock_symbols         = var.stock_symbols
}

module "lambda_processor" {
  source      = "./modules/lambda_processor"
  stream_arn  = module.kinesis_stream.stream_arn
  bucket_name = var.bucket_name
}

module "athena" {
  source        = "./modules/athena"
  bucket_name   = var.bucket_name
  database_name = "stock_data_db"
}

