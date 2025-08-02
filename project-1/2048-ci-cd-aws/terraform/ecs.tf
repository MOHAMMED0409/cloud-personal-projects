resource "aws_ecs_cluster" "main" {
  name = "ecs-2048-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "task-2048"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "game-2048"
      image     = "${aws_ecr_repository.game_repo.repository_url}:latest"
      portMappings = [{
        containerPort = 80
        hostPort      = 80
      }]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "ecs-2048-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = data.aws_subnets.default.ids
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }
  load_balancer {
  target_group_arn = aws_lb_target_group.ecs_tg.arn
  container_name   = "game-2048"
  container_port   = 80
}
 depends_on = [aws_lb_listener.http] # Ensures LB is ready before ECS starts
}

