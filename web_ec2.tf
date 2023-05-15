
resource "aws_instance" "web_instance" {
  count                       = 2
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  subnet_id                   = aws_subnet.public_subnet[count.index].id
  associate_public_ip_address = true
  key_name                    = "tf-key-pair"
  user_data                   = file("scripts/user_data.sh")
  tags = {
    Name = "web_instance_${count.index + 1}"
  }
}

resource "aws_key_pair" "tf-key-pair" {
  key_name   = "tf-key-pair"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tf-key-pair"
}


resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.rg_vpc.id
  tags = {
    Name = "web_sg"
  }
}

resource "aws_security_group_rule" "allow_trafic" {
  type                     = "ingress"
  from_port                = var.web_listener_port
  to_port                  = var.web_listener_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.web_sg.id
  description              = "allow trafic from lb to the web_sg"

}

resource "aws_security_group_rule" "allow_trafic_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
  description       = "allow trafic from lb to the web_sg"

}

resource "aws_security_group_rule" "allow_trafic_to_anywhere" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
}

