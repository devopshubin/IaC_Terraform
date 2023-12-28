provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "first-instance" {
  count                  = 1
  ami                    = "ami-0fc5d935ebf8bc3bc" # Change you ami id accordingly
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  key_name               = "us-east-1"
  vpc_security_group_ids = ["sg-0bdd2e6c598038e18"] # Change your security group id accordingly
  tags = {
    Name = "DevOps"
  }
}