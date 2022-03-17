resource "aws_subnet" "subnets" {
  count = length(var.SUBNETS)
  vpc_id     = element(var.SUBNETS, count.index)

  tags = {
    Name = "subnet-${count.index}"
  }
}