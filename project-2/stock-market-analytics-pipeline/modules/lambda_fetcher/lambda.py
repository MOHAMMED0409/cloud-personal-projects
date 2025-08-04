python
import os, boto3, json, requests

def lambda_handler(event, context):
    stream_name = os.environ['STREAM_NAME']
    symbol = "AAPL"
    api_key = "your_actual_api_key"
    url = f"https://api.polygon.io/v1/last/stocks/{symbol}?apiKey={api_key}"
    r = requests.get(url)
    kinesis = boto3.client("kinesis")
    kinesis.put_record(
        StreamName=stream_name,
        Data=json.dumps(r.json()),
        PartitionKey=symbol
    )