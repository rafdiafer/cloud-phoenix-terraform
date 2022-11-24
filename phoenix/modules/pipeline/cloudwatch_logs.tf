resource "aws_cloudwatch_log_group" "codebuild" {
  name              = "/${var.app_name}/codebuild"
  retention_in_days = 7
}