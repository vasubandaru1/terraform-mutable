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
    vpc_security_group_ids = [aws_security_group.mysql.id]
    db_subnet_group_name = aws_db_subnet_group.subnet-group.name
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



resource "aws_security_group" "mysql" {
  name        = "mysql-${var.ENV}"
  description = "mysql-${var.ENV}"
  vpc_id = data.terraform_remote_state.VPC.outputs.VPC_ID

  ingress {
    description      = "mysql"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = local.ALL_CIDR
    ipv6_cidr_blocks = []
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "mysql-${var.ENV}"
  }
}









resource "aws_route53_record" "mysql" {
  zone_id = data.terraform_remote_state.VPC.outputs.INTERNAL_HOSTEDZONE_ID
  name    = "mysql-${var.ENV}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_db_instance.mysql.address]
}

resource "null_resource" "schema-apply" {
  provisioner "local-exec" {
    command = <<EOF
sudo yum install mariadb -y
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
cd /tmp
unzip -o /tmp/mysql.zip
mysql -h${aws_db_instance.mysql.address} -u${local.rds_user} -p${local.rds_pass} <mysql-main/shipping.sql
EOF
  }
}