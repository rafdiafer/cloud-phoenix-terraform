resource "aws_security_group" "ecs_security_group" {
  name        = "${var.app_name}-ecs-security-group"
  description = "Security group that the ECS cluster will be using to allow communication to the app"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH for Bastion Host"
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [var.bastion_sg]
  }

  ingress {
    description     = "From ALB, for HC purposes"
    from_port       = 0
    to_port         = 65535
    protocol        = "TCP"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  egress {
    description = "Allowing every egress communication"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ECS Security group"
    Application = var.app_name
  }
}

resource "aws_security_group" "alb_security_group" {
  name        = "${var.app_name}-alb-security-group"
  description = "Security group that the ALB will be using to control access"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP communication allowed"
    from_port   = 0
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allowing every egress communication"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ALB Security group"
    Application = var.app_name
  }
}