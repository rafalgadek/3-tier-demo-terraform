# Creating 1st EC2 instance in Public Subnet
resource "aws_instance" "web_instance_1" {
  ami                         = "ami-0c9978668f8d55984"
  instance_type               = "t2.micro"
  count                       = 1
  
  vpc_security_group_ids      = ["${aws_security_group.web_sg.id}"]
  subnet_id                   = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true
  user_data                   = "${file("user_data.sh")}"
tags = {
  Name = "Web Instance 1"
}
}
# Creating 2nd EC2 instance in Public Subnet
resource "aws_instance" "web_instance_2" {
  ami                         = "ami-0c9978668f8d55984"
  instance_type               = "t2.micro"
  count                       = 1
  
  vpc_security_group_ids      = ["${aws_security_group.web_sg.id}"]
  subnet_id                   = "${aws_subnet.public-subnet-2.id}"
  associate_public_ip_address = true
  user_data                   = "${file("user_data.sh")}"
tags = {
  Name = "Web Instance 2"
}
}