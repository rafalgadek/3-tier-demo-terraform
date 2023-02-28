resource "aws_internet_gateway" "rg_gateway" {
  vpc_id = aws_vpc.rg_vpc.id
}