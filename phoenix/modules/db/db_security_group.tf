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

  tags = {
    Name = "Security Group for Bastion Host"
  }
}