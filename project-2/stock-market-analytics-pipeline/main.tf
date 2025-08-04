provider "aws" {
  region = var.aws_region
}

module "networking" {
  source = "./modules/networking"
}

module "kinesis" {
  source = "./modules/kinesis"
  stream_name = "stock-market-stream"
}

module "storage" {
  source = "./modules/storage"
}

module "lambda_fetcher" {
  source = "./modules/lambda_fetcher"
  stream_name = module.kinesis.stream_name
}

module "lambda_processor" {
  source = "./modules/lambda_processor"
  stream_name = module.kinesis.stream_name
  table_name = module.storage.dynamodb_table_name
  kinesis_arn = module.kinesis.stream_arn
}

module "glue" {
  source = "./modules/glue"
  glue_role_arn = module.glue.glue_role_arn
}

module "athena" {
  source      = "./modules/athena"
  bucket_name = module.storage.s3_bucket_name
}

module "sns_alerts" {
  source = "./modules/sns_alerts"
}