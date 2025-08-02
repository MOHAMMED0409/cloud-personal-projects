resource "aws_codebuild_project" "build_2048" {
  name          = "build-2048-game"
  service_role  = aws_iam_role.codebuild_role.arn
  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
  compute_type                = "BUILD_GENERAL1_SMALL"
  image                       = "aws/codebuild/standard:5.0"
  type                        = "LINUX_CONTAINER"
  privileged_mode             = true

   environment_variable {
    name  = "AWS_REGION"
    value = var.aws_region
  }
  
  environment_variable {
    name  = "ECR_REPO"
    value = aws_ecr_repository.game_repo.repository_url
  }
}


  source {
    type      = "GITHUB"
    location  = "https://github.com/${var.github_owner}/${var.github_repo}.git"
    git_clone_depth = 1
    buildspec = "project-1/2048/buildspec.yml"
  }

  source_version = var.github_branch
}
