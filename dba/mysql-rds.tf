resource "aws_db_instance" "mysql" {
  allocated_storage    = 10
  identifier           = "mysql-${var.ENV}"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "my_db"
  username             = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["RDS_MYSQL_USER"]
  password             = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["RDS_MYSQL_PASS"]
  parameter_group_name = aws_db_parameter_group.pg.name
  skip_final_snapshot  = true
}

resource "aws_db_parameter_group" "pg" {
  name   = "mysql-${var.ENV}-pg"
  family = "mysql5.7"

}

resource "aws_db_subnet_group" "subnet-group" {
  name       = "mysql-${var.ENV}-subnetgroup"
  subnet_ids = data.terraform_remote_state.VPC.outputs.PRIVATE_SUBNETS_IDS

  tags = {
    Name = "mysql-${var.ENV}-subnetgroup"
  }
}

