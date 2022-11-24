resource "aws_lb" "alb" {
  name                       = "${var.app_name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_security_group.id]
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = true

  tags = {
    Name        = "Application Load Balancer for Phoenix app"
    Application = var.app_name
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "${var.app_name}-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path    = var.health_check_path
    matcher = "200-304"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}