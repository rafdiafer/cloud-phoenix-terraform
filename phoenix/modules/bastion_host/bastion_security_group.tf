resource "aws_security_group" "bastion_sg" {
  name        = "${var.app_name}-bastion-host-security-group"
  description = "Security Group in use for this Bastion Host instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH communication"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.source_ip_bastion_host
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group for Bastion Host"
  }
}