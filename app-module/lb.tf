resource "aws_lb_target_group" "tg" {
  name     = local.tags["Name"]
  port     = var.port
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.VPC.outputs.VPC_ID
}

resource "aws_lb_target_group_attachment" "test" {
  count            =length(local.INSTANCE_IDS)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = element(local.INSTANCE_IDS,count.index )
  port             = 80
}
