
resource "aws_iam_role" "ecs_node_role" {
  name_prefix        = "ECS-execution-role"
  assume_role_policy = file("${path.module}/iam-role.json")
}