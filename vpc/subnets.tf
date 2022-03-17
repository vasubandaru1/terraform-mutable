resource "aws_subnet" "subnets" {
  depends_on            = [aws_vpc_ipv4_cidr_block_association.addon]
  count                 = length(var.SUBNETS)
  cidr_block            = element(var.SUBNETS, count.index)
  vpc_id                = aws_vpc.main.id
  availability_zone     = element(var.AZS, count.index)

  tags = {
    Name = "subnet-${count.index}"
  }
}