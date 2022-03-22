resource "aws_route53_zone_association" "association" {
  vpc_id  = aws_vpc.main.id
  zone_id = var.INTERNAL_HOSTEDZONE_ID
}