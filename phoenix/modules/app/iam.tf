// ECS Service role and policies
resource "aws_iam_role" "ecs_service_role" {
  name               = "${var.app_name}-ecs-service-role"
  assume_role_policy = file("${path.module}/policies/ecs_service_assume_role_policy.json")
}

resource "aws_iam_role_policy" "ecs_service_policy" {
  name   = "${var.app_name}-ecs-service-policy"
  role   = aws_iam_role.ecs_service_role.id
  policy = file("${path.module}/policies/ecs_service_policy.json")
}

//Autoscaling group role and policies
resource "aws_iam_role" "ecs_asg_role" {
  name               = "${var.app_name}-ecs-asg-role"
  assume_role_policy = file("${path.module}/policies/ecs_asg_assume_role_policy.json")
}

resource "aws_iam_role_policy" "ecs_asg_policy" {
  name   = "${var.app_name}-ecs-asg-policy"
  role   = aws_iam_role.ecs_asg_role.id
  policy = file("${path.module}/policies/ecs_asg_policy.json")
}

//Role for the ECS Task created
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.app_name}-ecs-task-role"
  assume_role_policy = file("${path.module}/policies/ecs_task_assume_role_policy.json")
}

resource "aws_iam_role_policy" "ecs_task_policy" {
  name   = "${var.app_name}-ecs-task-policy"
  role   = aws_iam_role.ecs_task_role.id
  policy = file("${path.module}/policies/ecs_task_policy.json")
}