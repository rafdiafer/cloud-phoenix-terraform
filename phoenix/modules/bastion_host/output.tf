output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
}

output "bastion_host_ip" {
  value = aws_instance.bastion_host.public_dns
}