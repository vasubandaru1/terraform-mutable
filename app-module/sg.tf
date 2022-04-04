resource "aws_security_group" "sg" {
  name        = local.tags["Name"]
  description = local.tags["Name"]
  vpc_id      = data.terraform_remote_state.VPC.outputs.VPC_ID

  ingress = [
    {
      description      = "APP"
      from_port        = var.port
      to_port          = var.port
      protocol         = "tcp"
      cidr_blocks      = local.ALL_VPC_CIDR
      ipv6_cidr_blocks = []
      self             = false
      security_groups =  []
      prefix_list_ids =  []

    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = local.ALL_CIDR
      ipv6_cidr_blocks = []
      self             = false
      security_groups  = []
      prefix_list_ids  = []
    }
  ]

  egress {
    description      = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    self             = false
    security_groups =  []
    prefix_list_ids =  []
  }


  tags = {
    Name = local.tags["Name"]
  }
}
