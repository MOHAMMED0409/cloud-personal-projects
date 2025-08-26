#!/bin/bash
set -e

# === VARIABLES ===
LAMBDA_DIR="./lambda_functions"
TF_DIR="./terraform"
PRODUCER_DIR="./producer"

echo "🚀 Starting Stock Market Pipeline Deployment..."

# === Step 0: Ensure dependencies ===
command -v terraform >/dev/null 2>&1 || { echo >&2 "❌ Terraform not installed. Aborting."; exit 1; }
command -v zip >/dev/null 2>&1 || { echo >&2 "❌ zip not installed. Aborting."; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo >&2 "❌ python3 not installed. Aborting."; exit 1; }

# === Step 1: Package Lambda Functions (before Terraform plan) ===
echo "🔹 Packaging Lambda functions..."
cd $LAMBDA_DIR
rm -f lambda_ingest.zip lambda_alert.zip
zip lambda_ingest.zip lambda_ingest.py > /dev/null
zip lambda_alert.zip lambda_alert.py > /dev/null
cd ..

# === Step 2: Terraform Init & Plan ===
echo "🔹 Initializing Terraform..."
cd $TF_DIR
terraform init -input=false

echo "🔹 Planning Terraform..."
terraform plan -out=tfplan

# === Step 3: Terraform Apply ===
echo "🔹 Deploying infrastructure with Terraform..."
terraform apply -input=false -auto-approve tfplan
cd ..

# === Step 4: Run Producer ===
echo "🔹 Running stock producer..."
cd $PRODUCER_DIR
nohup python3 stock_producer.py > producer.log 2>&1 &

echo "✅ Deployment complete!"
echo "👉 Stock data is flowing into Kinesis & S3"
echo "👉 Alerts will be sent via SNS if thresholds are crossed"
echo "👉 Check producer logs: tail -f $PRODUCER_DIR/producer.log"
