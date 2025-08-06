import os
import json
import boto3

def lambda_handler(event, context):
    sns = boto3.client('sns')
    topic_arn = os.environ['SNS_TOPIC_ARN']
    threshold = float(os.environ.get("PRICE_THRESHOLD", "150"))

    # Example input (from Kinesis or test event)
    stock_data = {
        "symbol": "AAPL",
        "price": 148.50
    }

    if stock_data["price"] < threshold:
        message = f"🚨 Alert: {stock_data['symbol']} dropped below ${threshold}. Current: ${stock_data['price']}"
        response = sns.publish(
            TopicArn=topic_arn,
            Message=message,
            Subject="Stock Price Alert"
        )
        return {
            'statusCode': 200,
            'body': json.dumps('Alert sent!')
        }

    return {
        'statusCode': 200,
        'body': json.dumps('No alert triggered.')
    }
