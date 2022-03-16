data "aws_route_tables" "default-vpc-routes" {
  vpc_id = aws_vpc.main.id
}
