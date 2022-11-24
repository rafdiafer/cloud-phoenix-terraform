data "aws_caller_identity" "current" {}

resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  name = "${var.app_name}-ecs-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_asg.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 100
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }

  tags = {
    Name = "ECS Capacity provider for ${var.app_name}"
    App  = var.app_name
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/temps/user_data.sh")

  vars = {
    messages_log_group = aws_cloudwatch_log_group.messages.name
    ecs_log_group      = aws_cloudwatch_log_group.ecs.name
    docker_log_group   = aws_cloudwatch_log_group.docker.name
  }
}

resource "aws_launch_template" "ecs_launch_template" {
  name_prefix                          = "${var.app_name}-ecs-launch-template"
  image_id                             = "ami-076309742d466ad69"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance_type
  key_name                             = var.aws_key_pair_name
  vpc_security_group_ids               = [aws_security_group.ecs_security_group.id]
  user_data                            = base64encode(data.template_file.user_data.rendered)

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  tags = {
    Name        = "ECS Cluster for the app"
    Application = var.app_name
  }

}

resource "aws_autoscaling_group" "ecs_asg" {
  name_prefix         = "${var.app_name}-ecs-asg"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.min_size
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "$Latest"
  }

  tags = [{
    Name        = "ECS Auto Scaling Group"
    Application = var.app_name
  }]

}

resource "aws_ecs_cluster" "ecs_cluster" {
  name               = var.app_name
  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]
}