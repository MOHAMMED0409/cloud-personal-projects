resource "aws_glue_job" "etl_cleaner" {
  name     = "stock-etl-job"
  role_arn = "arn:aws:iam::779846795398:role/service-role/AWSGlueServiceRole"
  command {
    name            = "glueetl"
    script_location = "s3://stock-raw-data-store/scripts/clean_stock_data.py"
    python_version  = "3"
  }
  max_retries         = 1
  glue_version        = "3.0"
  timeout             = 10
  number_of_workers   = 2
  worker_type         = "Standard"

  default_arguments = {
    "--TempDir" = "s3://stock-raw-data-store/temp/"
    "--class"   = "GlueApp"
  }
}
