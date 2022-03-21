#resource "aws_db_instance" "default" {
#  allocated_storage    = 10
#  engine               = "mysql"
#  engine_version       = "5.7"
#  instance_class       = "db.t3.micro"
#  name                 = "mysqldb"
#  username             = "admin"
#  password             = "admin123"
#  parameter_group_name = aws_db_parameter_group.pg.name
#  skip_final_snapshot  = true
#}


resource "aws_db_parameter_group" "pg" {
  name   = "mysql-${var.ENV}-pg"
  family = "mysql5.6"

}

resource "aws_db_subnet_group" "subnet-group" {
  name       = "mysql-subnet-group-${var.ENV}"
  subnet_ids = data.terraform_remote_state.VPC.outputs.PRIVATE_SUBNETS_IDS

  tags = {
    Name = "mysql-subnet-group-${var.ENV}"
  }
}

