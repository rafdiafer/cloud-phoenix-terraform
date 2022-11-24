variable "app_name" {
  description = "The name of the app"
  type        = string
  default     = "phoenix"
}

variable "aws_region" {
  description = "AWS region in use"
  type        = string
}

variable "environment" {
  description = "App environment"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_ids" {
  description = "List of public subnet ids that the ALB will be using to load balance the traffic"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet ids that the ASG instances will be using"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type to use for the ECS cluster"
  type        = string
}

variable "aws_key_pair_name" {
  description = "AWS Key pair name to use"
  type        = string
}

variable "min_size" {
  description = "ECS minimum number of instances"
  type        = string
}

variable "max_size" {
  description = "ECS maximum number of instances"
  type        = string
}

variable "health_check_path" {
  description = "HC Path"
  type        = string
  default     = "/"
}

variable "bastion_sg" {
  description = "Only allow the Bastion Host security group to SSH the instances"
}