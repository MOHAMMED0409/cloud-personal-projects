#!/bin/bash
cd terraform
terraform init
terraform apply -auto-approve -var-file="secrets.tfvars"

