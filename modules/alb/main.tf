# we will create an application load balancer 
resource "aws_lb" "app_load_balancer" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = [var.pub_subnet_1_id, var.pub_subnet_2_id]

  enable_deletion_protection = false

  tags = {
    Environment = "${var.project_name}-alb"
  }
}

# creating a target group that will be use with the application laod balancer
resource "aws_lb_target_group" "alb_target_group" {
  name     = "${var.project_name}"
  target_type = "ip"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled = true
    interval = 300
    path = "/"
    timeout = 60
    matcher = 200
    healthy_threshold = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}