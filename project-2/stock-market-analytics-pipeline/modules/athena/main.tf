resource "aws_glue_catalog_table" "cleaned_stock_data" {
  name          = "cleaned_stock_data"
  database_name = aws_athena_database.stock_db.name
  table_type    = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = "s3://stock-raw-data-store/cleaned/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    columns {
      name = "symbol"
      type = "string"
    }
    columns {
      name = "price"
      type = "double"
    }
    columns {
      name = "timestamp"
      type = "string"
    }
    columns {
      name = "volume"
      type = "bigint"
    }
  }

  partition_keys {
    name = "date"
    type = "string"
  }


  parameters = {
    EXTERNAL = "TRUE"
  }
}
