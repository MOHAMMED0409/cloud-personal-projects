variable "aws_region" {
  default = "us-east-1"
}

variable "github_owner" {
  default = "MOHAMMED0409"
}

variable "github_repo" {
  default = "cloud-personal-projects"
}

variable "github_branch" {
  default = "main"
}

variable "github_token" {
  type        = string
  description = "GitHub OAuth token for CodePipeline"
  sensitive   = true
}

variable "codestar_connection_arn" {
  description = "ARN of the GitHub CodeStar connection"
  type        = string
}
variable "project_name" {
  description = "The name of the project to use for resource naming"
  type        = string
}
