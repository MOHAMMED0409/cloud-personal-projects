output "ecr_url" {
  value = aws_ecr_repository.repo.repository_url
}

output "ecs_service_name" {
  value = aws_ecs_service.fargate_service.name
}

output "codecommit_repo_url" {
  value = aws_codecommit_repository.repo.clone_url_http
}
