variable "aws_region" {
  description = "AWS region for the infrastructure"
  type        = string
  default     = "eu-central-1"
}

variable "aws_az" {
  description = "Availability zones for the AWS region"
  type        = list(string)
  default = [
    "eu-central-1a",
    "eu-central-1b"
  ]
}

variable "aws_profile" {
  description = "AWS Profile"
  type        = string
}

variable "environment" {
  description = "App environment"
  type        = string
  default     = "Prod"
}

variable "aws_key_pair_name" {
  description = "AWS Key pair name to use"
  type        = string
  default     = "default_key_pair"
}

variable "app_name" {
  description = "The name of the app"
  type        = string
  default     = "phoenix"
}

variable "cidr_block" {
  description = "CIDR block for the each subnet"
  type        = string
  default     = "172.16.0.0/16"
}

variable "github_personal_token" {
  description = "Personal token to provide access to GitHub"
  type        = string
  #default     = ""
}

variable "github_repo" {
  description = "Github repository URL for the app"
  type        = string
  default     = "https://github.com/rafdiafer/cloud-phoenix-kata"
}

variable "github_repo_name" {
  description = "Github repository name"
  type        = string
  default     = "cloud-phoenix-kata"
}

variable "github_branch" {
  description = "GitHub branch name"
  type        = string
  default     = "main"
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
  #default     = "rafdiafer"
}

variable "ecr_image_url" {
  description = "ECR image URL"
  type        = string
  #default     = "022820857345.dkr.ecr.eu-central-1.amazonaws.com"
}

variable "instance_type" {
  description = "Instance type to use for the ECS cluster"
  type        = string
  default     = "t2.medium"
}

variable "min_size" {
  description = "ECS minimum number of instances"
  type        = string
  default     = "1"
}

variable "max_size" {
  description = "ECS maximum number of instances"
  type        = string
  default     = "4"
}

variable "bastion_host_ami" {
  description = "AMI in use for the Bastion Host instance"
  type        = string
  default     = "ami-076309742d466ad69"
}

variable "source_ip_bastion_host" {
  description = "Only allow my IP address (or list of IP addresses) to connect to the Bastion Host"
  type        = list(string)
  #default     = [""]
}

variable "container_name" {
  description = "Container name"
  type        = string
  default     = "phoenix"
}

variable "container_port" {
  description = "Application port"
  type        = string
  default     = "3000"
}

variable "sns_subscription_email_address_list" {
  description = "Email to send CPU peak alert"
  type        = string
  default     = "rafadiazfdez4@gmail.com"
}

variable "mongo_container_cpu" {
  description = "CPU capacity required for Mongo container (1024 == 1 CPU)"
  type        = number
  default     = 1024
}

variable "mongo_version" {
  description = "Docker image version of Mongo"
  type        = string
  default     = "latest"
}

variable "mongo_container_memory" {
  description = "Memory required for Mongo container"
  type        = number
  default     = 500
}

variable "mongo_username" {
  description = "MongoDB app username"
  type        = string
  default     = "user"
}

variable "mongo_root_pass" {
  description = "MongoDB Root user password"
  type        = string
  #default     = ""
}

variable "mongo_user_pass" {
  description = "MongoDB app user password"
  type        = string
  #default     = ""
}

variable "aws_public_key_path" {
  description = "Public key location"
  type        = string
  default     = ""
}