#!/bin/bash

# Pre-commit hook to check for common issues

echo "🔍 Running pre-commit checks..."

# Check for sensitive data in staged files
echo "Checking for sensitive data..."
if git diff --cached --name-only | xargs grep -l "password\|token\|key\|secret\|ghp_" 2>/dev/null; then
    echo "❌ WARNING: Potential sensitive data found in staged files!"
    echo "Please review and remove any sensitive information before committing."
    exit 1
fi

# Check for terraform state files
echo "Checking for terraform state files..."
if git diff --cached --name-only | grep -E "\.tfstate$|\.tfstate\."; then
    echo "❌ WARNING: Terraform state files detected!"
    echo "State files should not be committed. Add them to .gitignore."
    exit 1
fi

# Check for .tfvars files (might contain secrets)
echo "Checking for .tfvars files..."
if git diff --cached --name-only | grep -E "\.tfvars$"; then
    echo "⚠️  WARNING: .tfvars files detected!"
    echo "Make sure they don't contain sensitive data."
fi

# Check for proper .gitignore
if [ ! -f ".gitignore" ]; then
    echo "⚠️  WARNING: No .gitignore file found!"
    echo "Consider creating one to avoid committing unwanted files."
fi

echo "✅ Pre-commit checks passed!"
exit 0 