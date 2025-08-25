import boto3, requests, json, time
from config import ALPHA_VANTAGE_API_KEY, STOCK_SYMBOL, KINESIS_STREAM_NAME, REGION

kinesis = boto3.client("kinesis", region_name=REGION)

def get_stock_price():
    url = f"https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol={STOCK_SYMBOL}&apikey={ALPHA_VANTAGE_API_KEY}"
    r = requests.get(url)
    return r.json().get("Global Quote", {})

while True:
    data = get_stock_price()
    if data:
        record = json.dumps(data)
        kinesis.put_record(StreamName=KINESIS_STREAM_NAME, Data=record, PartitionKey=STOCK_SYMBOL)
        print("Pushed:", record)
    time.sleep(60)
