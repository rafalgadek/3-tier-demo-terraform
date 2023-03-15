resource "aws_vpc" "rg_vpc" {
  cidr_block       = var.rg_vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "rg_vpc"
  }
}

resource "aws_internet_gateway" "rg_gateway" {
  vpc_id = aws_vpc.rg_vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.rg_vpc.id
  tags = {
    Name = "public_rt"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.rg_gateway.id
}

resource "aws_route_table_association" "public_1" {
  count = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = {
    "Name" = "rg_nat_gateway"
  }
}

resource "aws_route_table" "nat_gateway_rt" {
  vpc_id = aws_vpc.rg_vpc.id
  tags = {
    "Name" = "nat_gateway_rt"
  }
}

resource "aws_route" "nat_gateway" {
  route_table_id         = aws_route_table.nat_gateway_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_gateway.id
}

resource "aws_route_table_association" "nat_gateway" {
  count = 4
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.nat_gateway_rt.id
}