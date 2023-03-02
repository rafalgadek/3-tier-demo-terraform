
resource "aws_lb" "alb" {
  name               = "alb-public-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_servers_tg.arn
  }
}

resource "aws_lb_target_group" "web_servers_tg" {
  name     = "web-servers-tg-${var.env}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.rg_vpc.id
}

resource "aws_lb_target_group_attachment" "az_1" {
  target_group_arn = aws_lb_target_group.web_servers_tg.arn
  target_id        = aws_instance.web_instance_1.id
  port             = var.app_listener_port
}

resource "aws_lb_target_group_attachment" "az_2" {
  target_group_arn = aws_lb_target_group.web_servers_tg.arn
  target_id        = aws_instance.web_instance_2.id
  port             = var.app_listener_port
}

resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.rg_vpc.id
  tags = {
    Name = "alb_sg"
  }
}

resource "aws_security_group_rule" "allow_trafic_from_alb" {
  type = "ingress"
  from_port = var.app_listener_port
  to_port = var.app_listener_port
  protocol = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
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

