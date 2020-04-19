variable "aws_region" {
    default = "ca-central-1"
}

variable "region" {
  default     = "ca-central-1"
  description = "AWS region"
}

variable "aws_rds_vpc" {
  type = map(string)
  default = {
    name = "sycle-rds-vpc"
    cidr = "10.1.0.0/24"
  }
}

variable "aws_rds_vpc_subnets" {
    type = list(string)
    default = ["10.1.0.0/26", "10.1.0.128/26", "10.1.0.64/26"]
}

variable "aws_rds_aurora_mysql" {
  type = map(string)
  default = {
    name = "sycle-rds-aurora-mysql"
    engine = "aurora-mysql"
    engine_version = "5.7.12"
  }
}
