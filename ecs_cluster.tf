# --- ECS Cluster ---
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "demo-cluster"

  tags = {
    Name = "demo-cluster"
  }
}


