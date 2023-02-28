
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.rg_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_1
  tags = {
    Name = "web_subnet_1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.rg_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_2
  tags = {
    Name = "web_subnet_2"
  }
}

resource "aws_subnet" "private-app-subnet-1" {
  vpc_id                  = aws_vpc.rg_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = var.availability_zone_1
  tags = {
    Name = "app_subnet_1"
  }
}

resource "aws_subnet" "private-application-subnet-2" {
  vpc_id                  = aws_vpc.rg_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = var.availability_zone_2
  tags = {
    Name = "app_subnet_2"
  }
}

resource "aws_subnet" "private-database-subnet-1" {
  vpc_id            = aws_vpc.rg_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = var.availability_zone_1
  tags = {
    Name = "db_subnet_1"
  }
}

resource "aws_subnet" "private-database-subnet-2" {
  vpc_id            = aws_vpc.rg_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = var.availability_zone_2
  tags = {
    Name = "db_subnet_2"
  }
}