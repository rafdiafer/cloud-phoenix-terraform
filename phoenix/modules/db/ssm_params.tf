resource "aws_ssm_parameter" "ssm_mongo_connection_url" {
  name        = "${var.app_name}-mongo-connection-url"
  description = "URL for the App to connect to MongoDB"
  type        = "SecureString"
  value       = "mongodb://${var.mongo_username}:${var.mongo_user_pass}@${aws_instance.mongo_ecs_instance.private_ip}:27017/phoenix_db"

  tags = {
    Application = var.app_name
  }
}

/*
resource "aws_ssm_parameter" "ssm_mongo_root_pass" {
    name = "${var.app_name}-mongo-root-pass"
    description = "Root user password"
    type = "SecureString"
    value = var.mongo_root_pass

    tags = {
        Application = var.app_name
    }
}

resource "aws_ssm_parameter" "ssm_mongo_user_pass" {
    name = "${var.app_name}-mongo-user-pass"
    description = "Root user password"
    type = "SecureString"
    value = var.mongo_user_pass

    tags = {
        Application = var.app_name
    }
}
*/