-- Create external table over raw stock data
CREATE EXTERNAL TABLE IF NOT EXISTS stock_db.raw_stock_data (
  symbol string,
  price double,
  timestamp string,
  volume bigint
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://stock-raw-data-store/'
TBLPROPERTIES ('has_encrypted_data'='false');

-- Get the latest price per stock
SELECT symbol, max(timestamp) AS latest_time, max(price) AS latest_price
FROM stock_db.raw_stock_data
GROUP BY symbol;

-- Find price changes over time for a given symbol
SELECT symbol, price, timestamp
FROM stock_db.raw_stock_data
WHERE symbol = 'AAPL'
ORDER BY timestamp DESC
LIMIT 10;

-- Average price by symbol
SELECT symbol, AVG(price) AS avg_price
FROM stock_db.raw_stock_data
GROUP BY symbol;

-- Detect anomalies (price jump > 5% from previous)
WITH price_deltas AS (
  SELECT
    symbol,
    price,
    lag(price) OVER (PARTITION BY symbol ORDER BY timestamp) AS prev_price,
    timestamp
  FROM stock_db.raw_stock_data
)
SELECT *
FROM price_deltas
WHERE (price - prev_price) / prev_price > 0.05;
