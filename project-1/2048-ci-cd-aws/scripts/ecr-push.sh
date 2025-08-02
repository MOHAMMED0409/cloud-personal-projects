#!/bin/bash

AWS_REGION="us-east-1"
REPO_NAME="game-2048"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REPOSITORY_URI="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}"

# Login to ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REPOSITORY_URI

# Build the Docker image
docker build -t ${REPO_NAME}:latest ./Users/mohammedkhashif/Documents/cloud personal projects/project-1/2048

# Tag and push to ECR
docker tag ${REPO_NAME}:latest ${REPOSITORY_URI}:latest
docker push ${REPOSITORY_URI}:latest

echo "✅ Image pushed to ECR: ${REPOSITORY_URI}:latest"
