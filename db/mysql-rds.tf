locals {
  rds_user = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["RDS_MYSQL_USER"]
  rds_pass = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["RDS_MYSQL_PASS"]
}


resource "aws_db_instance" "mysql" {
  allocated_storage    = 10
  identifier           = "mysql-${var.ENV}"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "dummy"
  username             = local.rds_user
  password             = local.rds_pass
  parameter_group_name = aws_db_parameter_group.pg.name
  skip_final_snapshot  = true
}


resource "aws_db_parameter_group" "pg" {
  name   = "mysql-${var.ENV}-pg"
  family = "mysql5.7"

}



resource "aws_db_subnet_group" "subnet-group" {
  name       = "mysql-subnet-group-${var.ENV}"
  subnet_ids = data.terraform_remote_state.VPC.outputs.PRIVATE_SUBNETS_IDS

  tags = {
    Name = "mysql-subnet-group-${var.ENV}"
  }
}

resource "aws_route53_record" "mysql" {
  zone_id = data.terraform_remote_state.VPC.outputs.INTERNAL_HOSTEDZONE_ID
  name    = "mysql-${var.ENV}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_db_instance.mysql.endpoint]
}

resource "null_resource" "schema-apply" {
  provisioner "local-exec" {
    command=<<EOF
yum install mariadb -y
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
cd /tmp
unzip /tmp/mysql.zip
mysql -h${aws_route53_record.mysql.fqdn} -u${local.rds_user} -p${local.rds_pass} <mysql-main/shipping.sql
EOF
  }
}