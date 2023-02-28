resource "aws_vpc" "rg_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "rg_vpc"
  }
}