
resource "aws_ecs_task_definition" "ecs_td" {
  family                   = "demo-application"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"                       # or "bridge", "host", "none" depending on your needs
  cpu                      = 256                            # CPU units
  memory                   = 512                            # Memory in MiB
  execution_role_arn       = aws_iam_role.ecs_node_role.arn # IAM role for ECS agent

  container_definitions = jsonencode([
    {
      name      = "demo-container"
      image     = "nginx:latest" 
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

#give other services to reach data about exist running tasks definition like CPU / memory,environment variables,log configuration
data "aws_ecs_task_definition" "ecs_td" {
  task_definition = aws_ecs_task_definition.ecs_td.family
}