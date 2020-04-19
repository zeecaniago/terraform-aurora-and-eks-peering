data "aws_caller_identity" "current" {}

resource "aws_vpc_peering_connection" "rds_eks" {
  vpc_id        = data.aws_vpc.eks.id
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = data.aws_vpc.rds.id
  auto_accept   = true
}

resource "aws_route" "eks_to_rds" {
  route_table_id            = data.aws_vpc.eks.main_route_table_id
  destination_cidr_block    = data.aws_vpc.rds.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.rds_eks.id
}

resource "aws_route" "rds_to_eks" {
  route_table_id            = data.aws_vpc.rds.main_route_table_id
  destination_cidr_block    = data.aws_vpc.eks.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.rds_eks.id
}