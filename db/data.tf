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
resource "aws_secretsmanager_secret_version" "secrets-version" {
  secret_id     = aws_secretsmanager_secret_version.secrets-version.id

}
output "example" {
  value = jsondecode(aws_secretsmanager_secret_version.secrets-version.secret_string)["RDS_MYSQL_USER"]
}
output "seccret" {
  value = data.aws_secretsmanager_secret.secrets
}