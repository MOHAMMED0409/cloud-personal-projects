resource "aws_s3_bucket" "athena_results" {
  bucket        = "${var.bucket_name}-athena-results"
  force_destroy = true
}

resource "aws_glue_catalog_database" "stock_db" {
  name = var.database_name
}

resource "aws_glue_catalog_table" "stock_table" {
  name          = "stock_prices"
  database_name = aws_glue_catalog_database.stock_db.name
  table_type    = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = "s3://${var.bucket_name}/raw/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "stock-serde"
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
      parameters = {
        "serialization.format" = 1
      }
    }

    columns{
        name = "low"
        type = "string"
      }
    columns{
        name = "price"
        type = "string"
      }
    columns{
        name = "volume"
        type = "string"
      }
    columns{
        name = "timestamp"
        type = "string"
      }
  }
}

output "athena_results_bucket" {
  value = aws_s3_bucket.athena_results.bucket
}

variable "bucket_name" {}
variable "database_name" {}
