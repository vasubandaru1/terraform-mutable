resource "aws_spot_instance_request" "spot" {
  count                = var.SPOT_INSTANCE_COUNT
  ami                  = data.aws_ami.ami.id
  instance_type        = var.INSTANCE_TYPE
  subnet_id             = element(data.terraform_remote_state.VPC.outputs.PRIVATE_SUBNETS_IDS,count.index)
  wait_for_fulfillment = true
}

resource "aws_instance" "od" {
  count                = var.OD_INSTANCE_COUNT
  ami                  = data.aws_ami.ami.id
  instance_type        = var.INSTANCE_TYPE
  subnet_id            = element(data.terraform_remote_state.VPC.outputs.PRIVATE_SUBNETS_IDS,count.index)

}

locals {
  INSTANCE_IDS = concat(aws_spot_instance_request.spot.*.spot_instance_id, aws_instance.od.*.id)
  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}

output "INSTANCE_IDS" {
  value = local.INSTANCE_IDS
}

resource "aws_ec2_tag" "ec2-name-tag" {
  count = length(local.INSTANCE_IDS)
  key         = "Name"
  resource_id = element(local.INSTANCE_IDS,count.index )
  value       = local.tags["Name"]
}
