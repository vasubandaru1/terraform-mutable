resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-${var.ENV}"
  engine               = "redis"
  node_type            = var.REDIS_INSTANCE_TYPE
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.redis.name
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  engine_version       = "6.x"
  port                 = 6379
  security_group_ids = [aws_security_group.redis.id]
}
resource "aws_elasticache_parameter_group" "redis" {
  family = "redis6.x"
  name   ="redis-${var.ENV}"
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "redis-${var.ENV}"
  subnet_ids = data.terraform_remote_state.VPC.outputs.PRIVATE_SUBNETS_IDS
}

resource "aws_security_group" "redis" {
  name        = "redis-${var.ENV}"
  description = "redis-${var.ENV}"
  vpc_id      = data.terraform_remote_state.VPC.outputs.VPC_ID

  ingress = [
    {
      description      = "REDIS"
      from_port        = 6379
      to_port          = 6379
      protocol         = "tcp"
      cidr_blocks      = local.ALL_CIDR
      ipv6_cidr_blocks = []
      self             = false
      security_groups =  []
      prefix_list_ids =  []

    }

  ]

  egress {
    description      = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    self             = false
    security_groups =  []
    prefix_list_ids =  []
  }


  tags = {
    Name = "redis-${var.ENV}"
  }
}

resource "aws_route53_record" "redis" {
  zone_id = data.terraform_remote_state.VPC.outputs.INTERNAL_HOSTEDZONE_ID
  name    = "redis-${var.ENV}"
  type    = "CNAME"
  ttl     = "300"
  records = aws_elasticache_cluster.redis.cache_nodes.*.address
}