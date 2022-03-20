resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.DEFAULT_VPC_CIDR
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
    gateway_id = ""
  }

  tags = {
    Name = "private-route"
  }
}


resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.main.id


  route = [
    {
    cidr_block                = var.DEFAULT_VPC_CIDR
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id

  },
    {
      depends_on                = [aws_route_table.public-route.id]
      cidr_block                = ["0.0.0.0/0"]
      gateway_id                = aws_internet_gateway.igw.id


    }

]
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
