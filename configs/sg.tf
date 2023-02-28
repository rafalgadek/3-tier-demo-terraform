
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.rg_vpc.id
  tags = {
    Name = "web_sg"
  }
}

resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.rg_vpc.id
  tags = {
    Name = "alb_sg"
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

resource "aws_security_group_rule" "allow_trafic_from_alb" {
  type = "ingress"
  from_port = var.app_listener_port
  to_port = var.app_listener_port
  protocol = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id = aws_security_group.web_sg.id  
}

resource "aws_security_group_rule" "allow_trafic_to_web_sg" {
  type = "egress"
  from_port = "0"
  to_port = "0"
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "allow_trafic_to_alb_sg" {
  type = "egress"
  from_port = "0"
  to_port = "0"
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.alb_sg.id
}
  