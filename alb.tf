resource "aws_lb" "loadtest_alb" {
  name               = "kickon-loadtest-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.loadtest_alb_sg.id]
  subnets            = local.subnet_ids

  tags = {
    Name = "kickon-loadtest-alb"
  }
}


resource "aws_lb_target_group" "loadtest_tg" {
  name     = "kickon-loadtest-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_lb_target_group_attachment" "ec2_attach" {
  target_group_arn = aws_lb_target_group.loadtest_tg.arn
  target_id        = aws_instance.loadtest_ec2.id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.loadtest_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.loadtest_tg.arn
  }
}
