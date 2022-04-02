resource "aws_security_group" "public-alb" {
  name        = "roboshop-public-alb-${var.ENV}"
  description = "roboshop-public-alb-${var.ENV}"
  vpc_id      = data.terraform_remote_state.VPC.outputs.VPC_ID

  ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
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
    security_groups  = []
    prefix_list_ids  = []
  }


  tags = {
    Name = "roboshop-public-alb-${var.ENV}"
  }
}

resource "aws_security_group" "private-alb" {
  name        = "roboshop-private-alb-${var.ENV}"
  description = "roboshop-private-alb-${var.ENV}"
  vpc_id      = data.terraform_remote_state.VPC.outputs.VPC_ID

  ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = data.terraform_remote_state.VPC.outputs.ALL_VPC_CIDR
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
    security_groups  = []
    prefix_list_ids  = []
  }


  tags = {
    Name = "roboshop-private-alb-${var.ENV}"
  }
}