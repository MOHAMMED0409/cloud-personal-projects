#!/bin/bash

# Project setup script for AWS/Terraform/Docker projects

echo "🚀 Setting up new project..."

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    echo "Creating .gitignore..."
    cat > .gitignore << 'EOF'
# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# Terraform
*.tfstate
*.tfstate.*
.terraform/
.terraform.lock.hcl
terraform.tfvars
secrets.tfvars
*.tfvars.json

# AWS
.aws/
aws-credentials

# Sensitive files
*.key
*.pem
*.p12
*.pfx
secrets/
.env
.env.local
.env.production

# Logs
*.log
logs/

# Temporary files
*.tmp
*.temp
.cache/
EOF
    echo "✅ .gitignore created"
else
    echo "ℹ️  .gitignore already exists"
fi

# Create README if it doesn't exist
if [ ! -f "README.md" ]; then
    echo "Creating README.md..."
    cat > README.md << 'EOF'
# Project Name

Brief description of your project.

## Prerequisites

- AWS CLI configured
- Terraform installed
- Docker installed

## Setup

1. Clone the repository
2. Run `./scripts/setup-project.sh`
3. Configure your AWS credentials
4. Run `terraform init`

## Usage

Describe how to use your project.

## Infrastructure

This project uses Terraform to manage AWS infrastructure.

## Security

- Never commit sensitive files
- Use AWS IAM roles when possible
- Follow the principle of least privilege
EOF
    echo "✅ README.md created"
else
    echo "ℹ️  README.md already exists"
fi

# Create terraform directory structure
if [ ! -d "terraform" ]; then
    echo "Creating terraform directory structure..."
    mkdir -p terraform
    cat > terraform/main.tf << 'EOF'
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Add your resources here
EOF
    echo "✅ Terraform directory created"
else
    echo "ℹ️  Terraform directory already exists"
fi

# Create variables.tf
if [ ! -f "terraform/variables.tf" ]; then
    cat > terraform/variables.tf << 'EOF'
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Add more variables as needed
EOF
    echo "✅ variables.tf created"
fi

# Create outputs.tf
if [ ! -f "terraform/outputs.tf" ]; then
    cat > terraform/outputs.tf << 'EOF'
# Add your outputs here
EOF
    echo "✅ outputs.tf created"
fi

echo "🎉 Project setup complete!"
echo ""
echo "Next steps:"
echo "1. Review and customize the generated files"
echo "2. Configure your AWS credentials"
echo "3. Run 'terraform init' in the terraform directory"
echo "4. Follow the pre-commit checklist before committing" 