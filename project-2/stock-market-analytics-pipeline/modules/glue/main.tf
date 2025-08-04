resource "aws_glue_crawler" "stock_crawler" {
  name          = "stock-crawler"
  role          = var.glue_role_arn
  database_name = aws_glue_catalog_database.stock_db.name

  s3_target {
    path = "s3://stock-raw-data-store/"
  }

  schedule = "cron(0/15 * * * ? *)"
}
resource "aws_glue_catalog_database" "stock_db" {
  name = "stock_db"
}