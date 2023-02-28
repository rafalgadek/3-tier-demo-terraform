
resource "aws_instance" "web_instance_1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  subnet_id                   = aws_subnet.public_subnet_1.id
  associate_public_ip_address = true
  user_data                   = file("../scripts/user_data.sh")
  tags = {
    Name = "web_instance_1"
  }
}

resource "aws_instance" "web_instance_2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  subnet_id                   = aws_subnet.public_subnet_2.id
  associate_public_ip_address = true
  user_data                   = file("../scripts/user_data.sh")
  tags = {
    Name = "web_instance_2"
  }
}