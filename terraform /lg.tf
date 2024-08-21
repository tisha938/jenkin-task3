resource "aws_lb_listener" "redirect" {
  load_balancer_arn = aws_lb.my_alb.arn
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

resource "aws_lb_listener" "forward_tg" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.Environment.certificate_1_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group_1.arn
  }
}
resource "aws_lb_listener_rule" "app-rule" {
  listener_arn = aws_lb_listener.forward_tg.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group_2.arn
  }
  condition {
    host_header {
      values = [local.Environment.my_domains[1]]
    }
  }
  # depends_on = [aws_lb_listener.forward_to_target_group, aws_lb_target_group.target_to_app]
}