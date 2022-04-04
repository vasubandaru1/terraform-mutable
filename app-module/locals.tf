locals {
  DEFAULT_VPC_CIDR = split(",", data.terraform_remote_state.VPC.outputs.DEFAULT_VPC_CIDR)
  ALL_VPC_CIDR     = data.terraform_remote_state.VPC.outputs.ALL_VPC_CIDR
  ALL_CIDR = concat(local.ALL_VPC_CIDR, local.DEFAULT_VPC_CIDR)
  //ssh_user = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["SSH_USER"]
  //ssh_pass = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["SSH_PASS"]
  INSTANCE_IDS = concat(aws_spot_instance_request.spot.*.spot_instance_id, aws_instance.od.*.id)
  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}