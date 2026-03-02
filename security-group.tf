
#in vpc file
resource "aws_security_group" "security_group" {
  name        = "ecs-sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "any"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #Means Allow Everything
    cidr_blocks = ["0.0.0.0/0"]
  }
}
