// ECS Service role and policies to use EBS, for MongoDB data persistence
resource "aws_iam_role" "ecs_mongo_ebs_role" {
  name               = "${var.app_name}-ecs-mongo-ebs-role"
  assume_role_policy = file("${path.module}/policies/ecs_ebs_assume_role_policy.json")
}

resource "aws_iam_role_policy" "ecs_ebs_policy" {
  name   = "${var.app_name}-ecs-mongo-ebs-policy"
  role   = aws_iam_role.ecs_mongo_ebs_role.id
  policy = file("${path.module}/policies/ecs_ebs_policy.json")
}