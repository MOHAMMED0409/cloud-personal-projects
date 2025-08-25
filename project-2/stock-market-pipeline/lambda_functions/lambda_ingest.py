import boto3, json, os
s3 = boto3.client("s3")
bucket = os.environ["BUCKET_NAME"]

def lambda_handler(event, context):
    for record in event['Records']:
        payload = record["kinesis"]["data"]
        data = json.loads(bytes(payload, 'utf-8').decode('base64'))
        key = f"stock_{data['01. symbol']}_{data['07. latest trading day']}.json"
        s3.put_object(Bucket=bucket, Key=key, Body=json.dumps(data))
    return {"status": "done"}
