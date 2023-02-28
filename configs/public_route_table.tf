resource "aws_route_table" "rg_rt" {
  vpc_id = aws_vpc.rg_vpc.id
    tags = {
    Name = "rg_route_table"
  }
}

resource "aws_route" "route" {
  route_table_id = aws_route_table.rg_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.rg_gateway.id
  
}

resource "aws_route_table_association" "rt1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.rg_rt.id
}

resource "aws_route_table_association" "rt2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.rg_rt.id
}