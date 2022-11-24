data "template_file" "buildspec" {
  template = file("${path.module}/buildspec/buildspec.yaml")
}

resource "aws_codebuild_source_credential" "github_token" {
  server_type = "GITHUB"
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  token       = var.github_personal_token
}

resource "aws_s3_bucket" "codepipeline_s3" {
  bucket = "phoenix-codepipeline-s3"
}

resource "aws_s3_bucket_acl" "codepipeline_s3_acl" {
  bucket = aws_s3_bucket.codepipeline_s3.id
  acl    = "private"
}

resource "aws_codebuild_project" "phoenix_project" {
  name           = "phoenix"
  description    = "Test CodeBuild Phoenix Project"
  build_timeout  = "5"
  queued_timeout = "5"
  service_role   = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "IMAGE_NAME"
      value = var.app_name
    }

    environment_variable {
      name  = "REGISTRY_URL"
      value = var.ecr_image_url
    }

    environment_variable {
      name  = "BUILD_ID"
      value = "latest"
    }

    environment_variable {
      name  = "DB_CONNECTION_STRING"
      value = var.ssm_mongo_connection_url
    }
  }

  logs_config {
    cloudwatch_logs {
      status     = "ENABLED"
      group_name = aws_cloudwatch_log_group.codebuild.name
    }
  }

  source {
    type            = "GITHUB"
    location        = var.github_repo
    git_clone_depth = 0
    buildspec       = data.template_file.buildspec.rendered
  }

  tags = {
    Name        = "Codebuild for Phoenix App"
    Environment = "test"
  }
}

resource "aws_codepipeline" "codepipeline_phoenix_project" {
  name     = "${var.app_name}-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_s3.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Repo       = var.github_repo_name
        Branch     = var.github_branch
        Owner      = var.github_owner
        OAuthToken = var.github_personal_token
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.app_name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ClusterName = "${var.app_name}"
        ServiceName = "${var.app_name}-ecs-service"
      }
    }
  }
}