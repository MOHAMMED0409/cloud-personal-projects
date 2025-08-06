import json
import os
import boto3
import uuid
from datetime import datetime

s3 = boto3.client('s3')
bucket_name = os.environ['BUCKET_NAME']

def lambda_handler(event, context):
    for record in event['Records']:
        payload = record['kinesis']['data']
        decoded_data = json.loads(base64.b64decode(payload).decode('utf-8'))

        # Optional formatting
        symbol = decoded_data.get("01. symbol", "UNKNOWN")
        timestamp = datetime.utcnow().strftime("%Y-%m-%dT%H-%M-%S")
        filename = f"{symbol}_{timestamp}_{uuid.uuid4().hex[:6]}.json"

        s3.put_object(
            Bucket=bucket_name,
            Key=f"raw/{filename}",
            Body=json.dumps(decoded_data)
        )
    return {"status": "processed"}
