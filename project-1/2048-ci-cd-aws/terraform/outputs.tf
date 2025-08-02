output "ecr_repo_url" {
  value = aws_ecr_repository.game_repo.repository_url
}

output "ecs_service_name" {
  value = aws_ecs_service.app.name
}
