output "VPC_ID" {
  value = aws_vpc.main.id
}

output "DEFAULT_VPC_ID" {
  value = var.DEFAULT_VPC_ID
}

output "PRIVATE_SUBNETS_IDS" {
  value = aws_subnet.private_subnets.*.id
}

output "PUBLIC_SUBNETS_IDS" {
  value = aws_subnet.public_subnets.*.id
}

output "PRIVATE_SUBNETS_CIDR" {
  value = aws_subnet.private_subnets.*.cidr_block
}

output "PUBLIC_SUBNETS_CIDR" {
  value = aws_subnet.public_subnets.*.cidr_block
}

output "DEFAULT_VPC_CIDR" {
  value = var.DEFAULT_VPC_CIDR
}