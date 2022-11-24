resource "aws_sns_topic" "cpu_alert_sns" {
  name = "${var.app_name}-cpu-alert-sns"

  provisioner "local-exec" {
    command = <<EOT
              for email in ${var.sns_subscription_email_address_list}; do
                echo $email
                aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint $email
              done
    EOT
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name          = "${var.app_name}-cpu-cloudwatch-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "65"
  alarm_description   = "This metric monitors ECS CPU utilization and calls SNS to send an email when CPU peaks happen"
  alarm_actions       = [aws_sns_topic.cpu_alert_sns.arn]
}