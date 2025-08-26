#!/bin/bash
set -e

echo "🔄 Resetting Stock Market Pipeline..."

# === Step 1: Run destroy.sh ===
echo "🛑 Destroying existing resources..."
./destroy.sh

# === Step 2: Run deploy.sh ===
echo "🚀 Redeploying pipeline..."
./deploy.sh

echo "✅ Reset complete. Fresh deployment is up and running."
