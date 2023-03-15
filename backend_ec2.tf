resource "aws_instance" "app_instance" {
  count = 2
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  subnet_id                   = aws_subnet.private_subnet[count.index].id
  associate_public_ip_address = true
  user_data                   = file("scripts/user_data.sh")
  tags = {
    Name = "app_instance_${count.index}"
  }
}


resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.rg_vpc.id
  tags = {
    Name = "app_sg"
  }
}

resource "aws_security_group_rule" "allow_trafic_from_web_sg" {
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = [var.public_subnet_cidrs[0], var.public_subnet_cidrs[1]]
  security_group_id = aws_security_group.app_sg.id
  description       = "allow trafic from web sg to app servers"
}

resource "aws_security_group_rule" "allow_trafic_out_off_app_sg" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg.id
}