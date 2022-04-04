resource "aws_lb_target_group" "tg" {
  name     = local.tags["Name"]
  port     = var.PORT
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.VPC.outputs.VPC_ID
  health_check {
    enabled              = true
    healthy_threshold    = 2
    interval             = 5
    path                 = "/health"
    unhealthy_threshold  = 2
    timeout              = 4
  }
}

resource "aws_lb_target_group_attachment" "tg-attach" {
  count            =length(local.INSTANCE_IDS)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = element(local.INSTANCE_IDS,count.index )
  port             = var.PORT
}

resource "aws_lb_listener_rule" "private" {
  listener_arn = join(",", data.terraform_remote_state.alb.outputs.PRIVATE_LISTENER_ARN)
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  condition {
    host_header {
      values = ["${var.COMPONENT}-${var.ENV}.roboshop.internal"]
    }
  }
}