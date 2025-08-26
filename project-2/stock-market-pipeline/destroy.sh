#!/bin/bash
set -e

# === VARIABLES ===
TF_DIR="./terraform"

echo "🛑 Destroying Stock Market Pipeline..."

# === Step 1: Kill Producer Process ===
echo "🔹 Checking for running stock producer..."
PRODUCER_PID=$(ps aux | grep "stock_producer.py" | grep -v grep | awk '{print $2}')

if [ -n "$PRODUCER_PID" ]; then
    echo "🔹 Killing producer process with PID $PRODUCER_PID"
    kill -9 $PRODUCER_PID
else
    echo "ℹ️ No producer process found running"
fi

# === Step 2: Terraform Destroy ===
cd $TF_DIR
echo "🔹 Destroying Terraform infrastructure..."
terraform destroy -auto-approve

# === Step 3: Cleanup ZIP files ===
echo "🔹 Removing packaged Lambda ZIPs..."
rm -f lambda_ingest.zip lambda_alert.zip

echo "✅ Cleanup complete. Stock Market Pipeline destroyed."
