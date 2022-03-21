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
data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}
resource "local_file" "secrets" {
  content  = jsondecode(data.aws_secretsmanager_secret_version.secret-version)["RDS_MYSQL_USER"]
  filename = tmp/1
}
#output "secrets" {
#  value = data.aws_secretsmanager_secret.secrets
#}