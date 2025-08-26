resource "aws_glue_catalog_database" "stock_db" {
  name = var.database_name
}

resource "aws_glue_catalog_table" "stock_table" {
  name          = "stock_prices"
  database_name = aws_glue_catalog_database.stock_db.name
  table_type    = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.raw.bucket}/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    columns {
      name = "symbol"
      type = "string"
    }
    columns {
      name = "price"
      type = "string"
    }
    columns {
      name = "volume"
      type = "string"
    }
    columns {
      name = "timestamp"
      type = "string"
    }
  
  ser_de_info {
      name                  = "json-serde"
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }
  }
}
