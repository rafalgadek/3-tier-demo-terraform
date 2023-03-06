variable "env" {
  type    = string
  default = "dev"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "ami" {
  type    = string
  default = "ami-03f255060aa887525"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "app_listener_port" {
  type    = number
  default = 80
}

variable "rg_vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "cidr address blocks for public subnets"
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "cidr address blocks for private subnets"
  default = [
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]
}

variable "db_name" {
  type    = string
  default = "terraform_test_db"

}
variable "db_password" {
  type    = string
  default = "<input your password>"
}





