resource "aws_ecs_service" "ecs_service" {
  name            = "${var.app_name}-ecs-service"
  cluster         = var.cluster
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = var.min_size
  iam_role        = aws_iam_role.ecs_service_role.arn

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu" #memory
  }

  load_balancer {
    target_group_arn = var.alb_target_group
    container_name   = var.container_name
    container_port   = var.container_port
  }

  lifecycle {
    ignore_changes = [
      desired_count
    ]
  }
}

data "template_file" "ecs_task_template" {
  template = file("${path.module}/temps/task_definition.json")

  vars = {
    container_name    = var.container_name
    container_port    = var.container_port
    ecr_image         = var.ecr_image_url
    aws_region        = var.aws_region
    service_log_group = aws_cloudwatch_log_group.service_logs.name
  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                = "service"
  container_definitions = data.template_file.ecs_task_template.rendered
  task_role_arn         = aws_iam_role.ecs_task_role.arn
}

resource "aws_cloudwatch_log_group" "service_logs" {
  name              = "/${var.app_name}/var/log/service"
  retention_in_days = 7
}

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.max_size
  min_capacity       = var.min_size
  resource_id        = "service/${var.cluster}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  role_arn           = aws_iam_role.ecs_asg_role.arn
}

resource "aws_appautoscaling_policy" "ecs_app_as_policy" {
  name               = "ecs-app-as-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = var.resource_label
    }

    target_value = 100
  }
}