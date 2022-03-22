locals {
  DEFAULT_VPC_CIDR = split(",", data.terraform_remote_state.VPC.outputs.DEFAULT_VPC_CIDR)
  ALL_CIDR = concat(data.terraform_remote_state.VPC.outputs.ALL_VPC_CIDR, local.DEFAULT_VPC_CIDR)
}