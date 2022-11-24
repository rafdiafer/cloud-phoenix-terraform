variable "app_name" {
  description = "Application name"
  type        = string
}

variable "github_personal_token" {
  description = "Personal token to provide access to GitHub"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository URL"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch name"
  type        = string
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "ecr_image_url" {
  description = "ECR image URL"
  type        = string
}

variable "ssm_mongo_connection_url" {
  description = "The URL to connect to Mongo"
  type        = string
}
