# --- ECS Service ---
resource "aws_ecs_service" "ecs_service" {
  name                               = "ecs_service"
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.ecs_td.arn
  scheduling_strategy                = "REPLICA"
  desired_count                      = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  depends_on                         = [aws_iam_role.ecs_node_role, aws_lb_listener.ecs_alb_listener]


  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_tg.arn
    container_name   = "demo-container"
    container_port   = 80 #may need to change to 8080
  }


  network_configuration {
    assign_public_ip = false # beacause we it runs in private subnets
    security_groups  = [aws_security_group.security_group.id]
    subnets          = [aws_subnet.subnet_3.id, aws_subnet.subnet_4.id]
  }
}