resource "aws_iam_role" "codebuild_role" {
  name               = "${var.app_name}-codebuild-role"
  assume_role_policy = file("${path.module}/policies/codebuild_assume_role_policy.json")
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "${var.app_name}-codebuild-policy"
  role   = aws_iam_role.codebuild_role.id
  policy = file("${path.module}/policies/codebuild_policy.json")
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "${var.app_name}-codepipeline-role"
  assume_role_policy = file("${path.module}/policies/codepipeline_assume_role_policy.json")
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "${var.app_name}-codepipeline-policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = file("${path.module}/policies/codepipeline_policy.json")
}