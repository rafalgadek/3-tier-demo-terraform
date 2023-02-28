resource "aws_vpc" "rg_vpc" {
  cidr_block       = var.rg_vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "rg_vpc"
  }
}