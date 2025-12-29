# ALB Security Group
resource "aws_security_group" "loadtest_alb_sg" {
  name        = "kickon-loadtest-alb-sg"
  description = "ALB SG for load test"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Security Group
resource "aws_security_group" "loadtest_ec2_sg" {
  name        = "kickon-loadtest-ec2-sg"
  description = "EC2 SG for load test"
  vpc_id      = data.aws_vpc.default.id

  # ALB → EC2 (HTTP)
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.loadtest_alb_sg.id]
  }

  # SSH (관리용)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["211.206.30.203/32"] # 내 ip만 허용
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
