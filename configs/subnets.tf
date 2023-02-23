# Create 1st web subnet 
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = "${aws_vpc.rg_vpc.id}"
  cidr_block             = "${var.subnet1_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
tags = {
  Name = "Web Subnet 1"
}
}
# Create 2nd web subnet 
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = "${aws_vpc.rg_vpc.id}"
  cidr_block             = "${var.subnet2_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
tags = {
  Name = "Web Subnet 2"
}
}
# Create 1st application subnet 
resource "aws_subnet" "application-subnet-1" {
  vpc_id                  = "${aws_vpc.rg_vpc.id}"
  cidr_block             = "${var.subnet3_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"
tags = {
  Name = "Application Subnet 1"
}
}
# Create 2nd application subnet 
resource "aws_subnet" "application-subnet-2" {
  vpc_id                  = "${aws_vpc.rg_vpc.id}"
  cidr_block             = "${var.subnet4_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "us-east-1b"
tags = {
  Name = "Application Subnet 2"
}
}
# Create Database Private Subnet
resource "aws_subnet" "database-subnet-1" {
  vpc_id            = "${aws_vpc.rg_vpc.id}"
  cidr_block        = "${var.subnet5_cidr}"
  availability_zone = "us-east-1a"
tags = {
  Name = "Database Subnet 1"
}
}
# Create Database Private Subnet
resource "aws_subnet" "database-subnet-2" {
  vpc_id            = "${aws_vpc.rg_vpc.id}"
  cidr_block        = "${var.subnet6_cidr}"
  availability_zone = "us-east-1b"
tags = {
  Name = "Database Subnet 2"
}
}