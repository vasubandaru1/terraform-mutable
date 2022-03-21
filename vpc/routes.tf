resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.PRIVATE_SUBNETS
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
    gateway_id = ""
  }

  tags = {
    Name = "private-route"
  }
}


resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.main.id


  route {
    cidr_block                = var.PUBLIC_SUBNETS
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id

  }


    tags = {
    Name = "public-route"
  }
}


resource "aws_route" "route-from-default-vpc" {
  count                  = length(local.association-list)
  route_table_id         = tomap(element(local.association-list, count.index))["route_table"]
  destination_cidr_block = tomap(element(local.association-list, count.index))["cidr"]
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
