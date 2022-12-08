variable "app_name" {
  description = "Application name"
  type        = string
}

variable "instance_type" {
  description = "Type of ECS container intance type"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the infrastructure"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet where the instances will be deployed"
  type        = list(string)
}

variable "mongo_container_cpu" {
  description = "CPU capacity required for mongo container ( 1024 == 1 cpu)"
  type        = number
}

variable "mongo_version" {
  description = "Docker image version of mongo"
  type        = string
}

variable "mongo_container_memory" {
  description = "Memory required for mongo container"
  type        = number
}

variable "mongo_username" {
  description = "MongoDB username"
  type        = string
}

variable "mongo_root_pass" {
  description = "Root user password"
  type        = string
}

variable "mongo_user_pass" {
  description = "Root user password"
  type        = string
}

variable "bastion_sg" {
  description = "Only allow Bastion Host security group to SSH the instances"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the each subnet"
  type        = string
}

variable "ecs_security_group" {
  description = "Security group for ECS"
}

variable "aws_az" {
  description = "Availability zones where deployed"
  type        = list(string)
}