resource "aws_cloudwatch_log_group" "messages" {
  name              = "/${var.app_name}/var/log/messages"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/${var.app_name}/var/log/ecs"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "docker" {
  name              = "/${var.app_name}/var/log/docker"
  retention_in_days = 7
}