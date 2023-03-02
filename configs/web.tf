
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

resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.rg_vpc.id
  tags = {
    Name = "web_sg"
  }
}

resource "aws_security_group_rule" "allow_trafic_from_anywhere" {
  type = "ingress"
  from_port = "80"
  to_port = "80"
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.alb_sg.id  
  description = "allow trafic from anywhere to the load balancer"
}

resource "aws_security_group_rule" "allow_trafic_to_web_sg" {
  type = "egress"
  from_port = "0"
  to_port = "0"
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.web_sg.id
}