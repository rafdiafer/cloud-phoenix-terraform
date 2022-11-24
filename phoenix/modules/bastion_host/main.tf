resource "aws_instance" "bastion_host" {
  ami                    = var.bastion_host_ami
  instance_type          = var.instance_type
  key_name               = var.aws_key_pair_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = var.subnet_id[0]

  tags = {
    "Name"      = "Bastion Host for ECS and MongoDB"
    Application = var.app_name
  }
}