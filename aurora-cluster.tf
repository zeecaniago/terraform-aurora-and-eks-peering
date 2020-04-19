data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.rds.id
}

resource "random_string" "rds_master_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  name    = var.aws_rds_aurora_mysql["name"]

  engine         = var.aws_rds_aurora_mysql["engine"]
  engine_version = var.aws_rds_aurora_mysql["engine_version"]

  vpc_id  = data.aws_vpc.rds.id
  subnets = data.aws_subnet_ids.all.ids

  replica_count       = 1
  instance_type       = "db.t2.medium"
  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

  db_parameter_group_name         = aws_db_parameter_group.aurora_db_57_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_57_cluster_parameter_group.id
  password                        = random_string.rds_master_password.result
  
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags = {
    Name = var.aws_rds_vpc["name"]
    Environment = "dev"
  }

  create_security_group = true
}

resource "aws_db_parameter_group" "aurora_db_57_parameter_group" {
  name        = "sycle-rds-aurora-db-57-parameter-group"
  family      = "aurora-mysql5.7"
  description = "test-aurora-db-57-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_57_cluster_parameter_group" {
  name        = "sycle-rds-aurora-57-cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "test-aurora-57-cluster-parameter-group"
}
