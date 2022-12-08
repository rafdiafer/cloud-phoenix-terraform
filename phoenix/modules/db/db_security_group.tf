resource "aws_security_group" "db_sg" {
  name        = "${var.app_name}-db-security-group"
  description = "Security Group in use for MongoDB"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow SSH communication"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [var.bastion_sg]
  }

  ingress {
    description     = "Instances to MongoDB"
    from_port       = 0
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [var.ecs_security_group]
  }

  egress {
    description = "Allowing every egress communication"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group for Bastion Host"
  }
}