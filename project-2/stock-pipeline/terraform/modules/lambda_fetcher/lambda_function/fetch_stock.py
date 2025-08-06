import os
import json
import boto3
import requests

def lambda_handler(event, context):
    api_key = os.getenv("API_KEY")
    stream_name = os.getenv("STREAM_NAME")
    symbols = os.getenv("STOCKS", "").split(",")

    kinesis = boto3.client("kinesis")

    for symbol in symbols:
        url = f"https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol={symbol}&apikey={api_key}"
        response = requests.get(url)
        data = response.json()

        if "Global Quote" in data:
            stock_data = data["Global Quote"]
            print(f"Pushing data for {symbol}: {stock_data}")
            kinesis.put_record(
                StreamName=stream_name,
                Data=json.dumps(stock_data),
                PartitionKey=symbol
            )
        else:
            print(f"Failed to get data for {symbol}: {data}")

    return {"status": "done"}
