# Pre-Commit Checklist

## Before Every Commit:

### 🔒 Security Check
- [ ] No API keys, tokens, or passwords in code
- [ ] No AWS credentials in files
- [ ] No personal access tokens
- [ ] Check for sensitive data in new files

### 📁 File Organization
- [ ] `.gitignore` is properly configured
- [ ] Only necessary files are tracked
- [ ] Terraform state files are excluded
- [ ] Sensitive `.tfvars` files are excluded

### 🐳 Docker
- [ ] Dockerfile is optimized
- [ ] No secrets in Dockerfile
- [ ] `.dockerignore` is configured

### ☁️ AWS/Terraform
- [ ] Terraform files are included (not excluded)
- [ ] State files are excluded
- [ ] Variables are properly defined
- [ ] No hardcoded values

### 📝 Documentation
- [ ] README is updated
- [ ] Comments are clear
- [ ] Commit message is descriptive

## Quick Commands:
```bash
# Check what will be committed
git status

# Check for sensitive data
grep -r "password\|token\|key\|secret" . --exclude-dir=.git

# Check .gitignore effectiveness
git check-ignore *

# Review staged changes
git diff --cached
``` 