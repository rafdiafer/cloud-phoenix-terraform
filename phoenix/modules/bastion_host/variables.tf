variable "app_name" {
  description = "Application Name"
  type        = string
}

variable "aws_key_pair_name" {
  description = "Key pair name in use for the application deployment"
  type        = string
}

variable "aws_az" {
  description = "Availability Zones in use for the deployment"
  type        = list(string)
}

variable "bastion_host_ami" {
  description = "AMI in use for the Bastion Host instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the Bastion Host"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "source_ip_bastion_host" {
  description = "For security reasons, only allow this IP address to connect to the Bastion Host"
  type        = list(string)
}

variable "subnet_id" {
  description = "Subnets where the instances will be deployed"
  type        = list(string)
}