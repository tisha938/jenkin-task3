resource "aws_lb_target_group" "my_target_group_1" {
  name     = local.Environment.target_group_1_name
  port     = 8080
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  health_check {
    path                = "/login"
    port =8080
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "my_target_group_1_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group_1.arn
  target_id        = aws_instance.my_private_instance.id
  port             = 8080
}
resource "aws_lb_target_group" "my_target_group_2" {
  name     = local.Environment.target_group_2_name
  port     = 1000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  health_check {
    path                = "/"
    port =1000
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "my_target_group_2_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group_2.arn
  target_id        = aws_instance.my_private_instance.id
  port             = 1000
}
