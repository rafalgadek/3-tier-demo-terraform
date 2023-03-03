
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.rg_vpc.id
  cidr_block              = var.public_subnet_1_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "web_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.rg_vpc.id
  cidr_block              = var.public_subnet_2_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "web_subnet_2"
  }
}

resource "aws_subnet" "private_app_subnet_1" {
  vpc_id            = aws_vpc.rg_vpc.id
  cidr_block        = var.private_app_subnet_1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "app_subnet_1"
  }
}

resource "aws_subnet" "private_app_subnet_2" {
  vpc_id            = aws_vpc.rg_vpc.id
  cidr_block        = var.private_app_subnet_2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "app_subnet_2"
  }
}

resource "aws_subnet" "private_database_subnet_1" {
  vpc_id            = aws_vpc.rg_vpc.id
  cidr_block        = var.private_database_subnet_1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "db_subnet_1"
  }
}

resource "aws_subnet" "private_database_subnet_2" {
  vpc_id            = aws_vpc.rg_vpc.id
  cidr_block        = var.private_database_subnet_2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "db_subnet_2"
  }
}