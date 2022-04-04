data "terraform_remote_state" "VPC" {
  backend = "s3"
  config = {
    bucket = "vasudevops"
    key    = "terraform-mutable/vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
}

}

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "base"
  owners      = ["self"]

}

data "aws_secretsmanager_secret" "secrets" {
  name = var.ENV
}
data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

#data "aws_ami" "ami" {
#  most_recent = true
#  name_regex  = "Centos-7-DevOps-Practice"
#  owners      = [973714476881]
#}

