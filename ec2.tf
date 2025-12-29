resource "aws_instance" "loadtest_ec2" {
  ami           = "ami-040c33c6a51fd5d96"
  instance_type = "t2.small"

  vpc_security_group_ids = [
    aws_security_group.loadtest_ec2_sg.id
  ]

  key_name = "kickon-loadtest"

  tags = {
    Name = "kickon-loadtest-ec2"
  }
}

