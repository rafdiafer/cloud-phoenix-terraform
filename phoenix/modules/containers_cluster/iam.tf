resource "aws_iam_role" "ecs_role" {
  name               = "${var.app_name}-ecs-role"
  assume_role_policy = file("${path.module}/policies/ecs_assume_role_policy.json")
}

resource "aws_iam_role_policy" "ecs_policies" {
  name   = "${var.app_name}-ecs-policies"
  role   = aws_iam_role.ecs_role.id
  policy = file("${path.module}/policies/ecs_policy.json")
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "${var.app_name}-ecs-instance-profile"
  role = aws_iam_role.ecs_role.id
}