#!/bin/bash
cd terraform
terraform destroy -auto-approve -var-file="secrets.tfvars"
