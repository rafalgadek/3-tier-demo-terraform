resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private_subnet[2].id, aws_subnet.private_subnet[3].id]
}

resource "aws_db_instance" "rds_db" {
  allocated_storage      = 5
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = var.db_name
  username               = var.db_name
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.rg_vpc.id
  tags = {
    Name = "rds_sg"
  }
}

resource "aws_security_group_rule" "allow_trafic_from_app_sg" {
  type              = "ingress"
  from_port         = "3306"
  to_port           = "3306"
  protocol          = "tcp"
  cidr_blocks       = [var.private_subnet_cidrs[0], var.private_subnet_cidrs[1]]
  security_group_id = aws_security_group.rds_sg.id
  description       = "allow trafic from app sg to database"
}

resource "aws_security_group_rule" "allow_trafic_out_from_rds_sg" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_sg.id
  description       = "allow trafic from rd sg to anywhere"

}