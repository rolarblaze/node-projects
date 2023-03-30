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

# create a listener on port 80 with a redirect 

resource "aws_lb_listener" "lb_listener_redirect" {
  load_balancer_arn = aws_lb.app_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# create a listener on port 443 with a forward action
resource "aws_lb_listener" "lb_listener_forward" {
  load_balancer_arn = aws_lb.app_load_balancer.arn
  port              = "80"
  protocol          = "HTTPS"
  ssl_policy = "ELBSecurityPlicy-2016-08"
  #certificate_arn = 

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}
