resource "aws_lb" "alb" {
  provider           = aws.region-master
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.m-sub-1.id, aws_subnet.m-sub-1.id]

  tags = {
    Environment = "production"
    Name        = "alb-jenkins"
  }
}

# Target group for ALB
resource "aws_lb_target_group" "alb-tg" {
  provider                      = aws.region-master
  name                          = "alb-tg"
  port                          = var.alb_port
  protocol                      = "HTTP"
  target_type                   = "instance"
  vpc_id                        = aws_vpc.master.id
  load_balancing_algorithm_type = "round_robin"

  health_check {
    enabled           = true
    healthy_threshold = 3
    interval          = 5
    matcher           = "200-299"
    path              = "/"
    port              = var.alb_port
    protocol          = "HTTP"
  }
  tags = {
    Name = "jenkins-tg"
  }
}


# Listner for ALB
resource "aws_lb_listener" "jenkins-listner-http" {
  provider          = aws.region-master
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}

# Attaching TG to instance
resource "aws_lb_target_group_attachment" "attach-tg-jenkins-master" {
  provider         = aws.region-master
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = aws_instance.jenkins-master.id
  port             = var.alb_port
}
