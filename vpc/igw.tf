resource "aws_internet_gateway" "igw" {
  depends_on = [aws_vpc_peering_connection.peer]
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.ENV}-igw"
  }
}