resource "aws_route_table" "route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "172.31.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id

    gateway_id = ""
  }

  route {
    ipv6_cidr_block        = ""
    egress_only_gateway_id = ""
  }

  tags = {
    Name = "example"
  }
}