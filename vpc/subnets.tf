resource "aws_subnet" "subnets" {
  count                 = length(var.SUBNETS)
  cidr_block            = element(var.SUBNETS, count.index)
  vpc_id                = aws_vpc.main.id

  tags = {
    Name = "subnet-${count.index}"
  }
}