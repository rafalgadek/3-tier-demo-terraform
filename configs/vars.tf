variable "env" {
  type = string
  default = "dev"
}

variable "region" {
  type = string
  default = "eu-central-1"
}

variable "ami" {
  type = string
  default = "ami-03f255060aa887525"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}


variable "availability_zone_1" {
  type = string
  default = "eu-central-1a"
}

variable "availability_zone_2" {
  type = string
  default = "eu-central-1b"
}


