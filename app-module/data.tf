#data "terraform_remote_state" "VPC" {
#  backend = "s3"
#  config = {
#    bucket = "vasudevops"
#    key    = "terraform-mutable/vpc/${var.ENV}/terraform.tfstate"
#    region = "us-east-1"
#}
#
#}

#data "aws_ami" "ami" {
#  most_recent = true
#  name_regex  = "base"
#  owners      = ["self"]
#}

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "Centos-7-DevOps-Practice"
  owners      = [973714476881]
}

