# Create App Security Group 
resource "aws_security_group" "web_sg" {
  vpc_id = "${aws_vpc.rg_vpc.id}"

# Inbound Rules
# HTTP access from Alb
ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  security_groups = [aws_security_group.alb_sg.id]
}

# Outbound Rules
# Internet access to anywhere
egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
tags = {
  Name = "Web SG"
}
}