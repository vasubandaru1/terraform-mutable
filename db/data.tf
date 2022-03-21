data "terraform_remote_state" "VPC" {
  backend = "s3"
  config = {
    bucket = "vasudevops"
    key    = "terraform-mutable/db/dev/terraform.tfstate"
    region = "us-east-1"
}

}

data "aws_secretsmanager_secret" "secrets" {
  name = "${var.ENV}-secretmanager"
}
output "seccret" {
  value = data.aws_secretsmanager_secret.secrets
}