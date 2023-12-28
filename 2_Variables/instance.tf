resource "aws_instance" "dev-instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.Zone1
  key_name               = "Control-key"
  vpc_security_group_ids = ["sg-012781f04be49cf6a"]
  tags = {
    Name = "DevOpsHub"
  }
}