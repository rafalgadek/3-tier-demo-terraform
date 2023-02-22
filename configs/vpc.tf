resource "aws_vpc" "rg_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "RG VPC"
  }
}