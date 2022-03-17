resource "aws_vpc_peering_connection" "peer" {
  peer_vpc_id   = var.DEFAULT_VPC_ID
  vpc_id        = aws_vpc.main.id
  auto_accept   = true

  tags = {
    Name = "${var.ENV}-default-vpc-to-vpc"
  }
}

