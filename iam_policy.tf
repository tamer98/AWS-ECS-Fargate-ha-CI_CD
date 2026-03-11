
resource "aws_iam_role_policy" "iam_policy" {
  name   = "ECS-execution-role-policy"
  role   = aws_iam_role.ecs_node_role.id
  policy = file("${path.module}/iam-policy.json")
}


resource "aws_iam_role_policy" "iam_policy_grafana" {
  name   = "ECS_Grafana-execution-role-policy"
  role   = aws_iam_role.ecs_node_role_grafana.id
  policy = file("${path.module}/iam-policy-grafana.json")
}