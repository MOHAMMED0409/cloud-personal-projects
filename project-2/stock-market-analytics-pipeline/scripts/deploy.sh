#bash
#!/bin/bash
zip -j lambda.zip modules/lambda_fetcher/lambda.py
cp lambda.zip modules/lambda_fetcher/
zip -j lambda.zip modules/lambda_processor/lambda.py
cp lambda.zip modules/lambda_processor/
terraform init && terraform apply -auto-approve