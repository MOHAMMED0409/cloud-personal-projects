SELECT symbol, price, volume, timestamp
FROM stock_prices
WHERE CAST(price AS DOUBLE) > 150
ORDER BY timestamp DESC
LIMIT 10;
