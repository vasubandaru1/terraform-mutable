resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.ENV}-igw"
  }
}
output "aws_gateway" {
  value = "aws_internet_gateway.igw.id"
}