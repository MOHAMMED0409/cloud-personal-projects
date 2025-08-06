CREATE EXTERNAL TABLE IF NOT EXISTS stock_data_db.stock_prices (
  symbol string,
  open string,
  high string,
  low string,
  price string,
  volume string,
  timestamp string
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = '1'
)
LOCATION 's3://stock-data-bucket-demo-khashif/raw/';
