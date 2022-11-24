variable "app_name" {
  description = "The name of the app"
  type        = string
}

variable "environment" {
  description = "App environment"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the each subnet"
  type        = string
}

variable "aws_az" {
  description = "Availability zones for the AWS region"
  type        = list(string)
}
