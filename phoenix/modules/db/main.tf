resource "aws_ecs_cluster" "mongo_ecs" {
  name = "${var.app_name}-mongo-ecs"

  tags = {
    Name        = "MongoDB Containers for the app"
    Application = var.app_name
  }
}

resource "aws_ecs_task_definition" "mongo_task" {
  family                = "service"
  container_definitions = data.template_file.container_definition.rendered
  network_mode          = "bridge"

  volume {
    name = "${var.app_name}-mongo-ebs-volume"

    docker_volume_configuration {
      scope         = "shared"
      autoprovision = true
      driver        = "rexray/ebs"
    }
  }
}

resource "aws_ecs_service" "mongodb_ecs_service" {
  name                               = "${var.app_name}-mongo-ecs-service"
  cluster                            = aws_ecs_cluster.mongo_ecs.arn
  task_definition                    = aws_ecs_task_definition.mongo_task.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
  launch_type                        = "EC2"
}

data "template_file" "container_definition" {
  template = file("${path.module}/temps/task_definition.json")

  vars = {
    mongo_version          = var.mongo_version
    mongo_container_cpu    = var.mongo_container_cpu
    mongo_container_memory = var.mongo_container_memory
    mongo_root_pass        = var.mongo_root_pass
    mongo_username         = var.mongo_username
    mongo_user_pass        = var.mongo_user_pass
    volume                 = "${var.app_name}-mongo-ebs-volume"
  }
}


resource "aws_instance" "mongo_ecs_instance" {
  ami                    = "ami-076309742d466ad69" //data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  subnet_id              = var.subnet_id[0] #single instance mongodb
}

