import boto3, json, os, base64

sns = boto3.client("sns")
topic_arn = os.environ["SNS_TOPIC_ARN"]

def lambda_handler(event, context):
    for record in event['Records']:
        payload = base64.b64decode(record["kinesis"]["data"]).decode("utf-8")
        data = json.loads(payload)
        price = float(data.get("05. price", 0))
        
        if price > 200:  # threshold example
            message = f"🚨 Stock {data['01. symbol']} crossed ${price}"
            sns.publish(TopicArn=topic_arn, Message=message)
            print("Alert sent:", message)
    return {"status": "alerts checked"}
