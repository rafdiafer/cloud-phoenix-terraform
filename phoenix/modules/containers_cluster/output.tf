output "cluster" {
  value = aws_ecs_cluster.ecs_cluster.id
}

output "alb_target_group" {
  value = aws_lb_target_group.alb_target_group.id
}

output "ecs_security_group" {
  value = aws_security_group.ecs_security_group.id
}

output "alb_url" {
  value = aws_lb.alb.dns_name
}

# For the following variables, needed for the Autoscaling,
# I need to get only the last part of the arn for these elements:

output "resource_label" {
  value = replace(aws_lb.alb.arn, "arn:aws:elasticloadbalancing:${var.aws_region}:${data.aws_caller_identity.current.account_id}:loadbalancer/", "")
}

output "resource_label_target" {
  value = replace(aws_lb_target_group.alb_target_group.arn, "arn:aws:elasticloadbalancing:${var.aws_region}:${data.aws_caller_identity.current.account_id}:", "")
}