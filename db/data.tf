data "terraform_remote_state" "VPC" {
  backend = "s3"
  config = {
    bucket = "vasudevops"
    key    = "terraform-mutable/db/dev/terraform.tfstate"
    region = "us-east-1"
}

}

data "aws_secretsmanager_secret" "secrets" {
  name = var.ENV
}
resource "aws_secretsmanager_secret_version" "secrets" {
  secret_id     = aws_secretsmanager_secret_version.secrets.id["RDS_MYSQL_USER"]

}
output "example" {
  value = jsondecode(aws_secretsmanager_secret_version.secrets.secret_string)
}
output "seccret" {
  value = data.aws_secretsmanager_secret.secrets
}