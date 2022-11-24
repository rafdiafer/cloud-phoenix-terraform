variable "aws_region" {
  description = "AWS region for the infrastructure"
  type        = string
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "AWS Profile"
  type        = string
}

variable "app_name" {
  description = "The name of the app"
  type        = string
  default     = "phoenix"
}