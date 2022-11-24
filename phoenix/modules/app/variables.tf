variable "app_name" {
  description = "App name"
  type        = string
}

variable "environment" {
  description = "App environment"
  type        = string
}

variable "cluster" {
  description = "ECS cluster"
  type        = string
}

variable "ecr_image_url" {
  description = "ECR URL for the image"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances for the app"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances for the app"
  type        = number
}

variable "alb_target_group" {
  description = "ALB target group"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_port" {
  description = "Application port"
  type        = string
}

variable "sns_subscription_email_address_list" {
  description = "Email to send CPU peak alert"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the infrastructure"
  type        = string
}

variable "resource_label" {
  description = "Resource label for the ALB Autoscaling"
  type        = string
}