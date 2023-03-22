resource "aws_security_group" "alb_security_group" {
  name        = "elastic load balancer security group"
  description = "Allow http/https traffic on port 80"
  vpc_id      = var.vpc_id

  ingress {
    description      = "allow tcp traffic only on port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "allow tcp traffic only on port 443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "alb security group"
  }
}
resource "aws_security_group" "ecs_security_group" {
  name        = "ecs security group"
  description = "Allow http/https traffic on port 80/443 via alb sg"
  vpc_id      = var.vpc_id

  ingress {
    description      = "allow http access on port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description      = "allow http access on port 443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_security_group.alb_security_group.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ecs security group"
  }
}