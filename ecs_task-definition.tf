
resource "aws_ecs_task_definition" "ecs_td" {
  family                   = "demo-application"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_node_role.arn

  container_definitions = jsonencode([
    {
      name      = "demo-container"
      image     = "tamer98/my-app:v1.0.0"
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

      logConfiguration = {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/app",
          "awslogs-region" : "ap-south-1",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])
}


resource "aws_ecs_task_definition" "ecs_td_grafana" {
  family                   = "grafana-application"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_node_role_grafana.arn

  container_definitions = jsonencode([
    {
      name      = "grafana-container"
      image     = "grafana/grafana"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "GF_SERVER_ROOT_URL"
          value = "%(protocol)s://%(domain)s/grafana/"
        },
        {
          name  = "GF_SERVER_SERVE_FROM_SUB_PATH"
          value = "true"
        }
      ]

      logConfiguration = {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/grafana",
          "awslogs-region" : "ap-south-1",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])
}

#give other services to reach data about exist running tasks definition like CPU / memory,environment variables,log configuration
data "aws_ecs_task_definition" "ecs_td" {
  task_definition = aws_ecs_task_definition.ecs_td.family
}