#Create ALB
resource "aws_lb" "alb" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}
#Create target group
resource "aws_lb_target_group" "alb" {
  name     = "ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.rg_vpc.id
}

resource "aws_lb_target_group_attachment" "alb1" {
  target_group_arn = aws_lb_target_group.alb.arn
  target_id        = aws_instance.web_instance_1.id
  port             = 80

  depends_on = [
    aws_instance.web_instance_1,
  ]
}

resource "aws_lb_target_group_attachment" "alb2" {
  target_group_arn = aws_lb_target_group.alb.arn
  target_id        = aws_instance.web_instance_2.id
  port             = 80

  depends_on = [
    aws_instance.web_instance_2,
  ]
}
#Create ALB
resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }
}