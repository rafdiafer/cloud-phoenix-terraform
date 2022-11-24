variable "app_name" {
  description = "The name of the app"
  type        = string
  default     = "phoenix"
}

variable aws_region {
  description = "AWS region in use"
  type = string
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

#############################################################

/*

variable "ecs_logging" {
  type        = string
  default     = "[\\\"json-file\\\",\\\"awslogs\\\"]"
  description = "Adding logging option to ECS that the Docker containers can use."
}

variable "ecs_config" {
  type        = string
  default     = "echo '' > /etc/ecs/ecs.config"
  description = "Specify ecs configuration or get it from S3. Example: aws s3 cp s3://some-bucket/ecs.config /etc/ecs/ecs.config"
}

variable "bastion_sg" {
  type = string

  description = <<DESCRIPTION
Bastion host instance security group id
from where the SSH access to the autoscaling instances
is allowed.
DESCRIPTION
}

*/