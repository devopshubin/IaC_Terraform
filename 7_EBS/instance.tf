resource "aws_key_pair" "dev-key" {
  key_name   = var.PRIV_KEY
  public_key = file("devkey.pub")
}

resource "aws_instance" "dev-web" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.dev-pub-1.id
  key_name               = aws_key_pair.dev-key.key_name
  vpc_security_group_ids = [aws_security_group.dev_stack_sg.id]
  tags = {
    Name    = "DevOpsHub"
    Project = "DevOps"
  }
}

resource "aws_ebs_volume" "vol_4_dev" {
  availability_zone = "us-east-1a"
  size              = 3
  tags = {
    Name = "extra-vol-4-dev"
  }
}

resource "aws_volume_attachment" "atch_vol_dev" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.vol_4_dev.id
  instance_id = aws_instance.dev-web.id
}

output "PublicIP" {
  value = aws_instance.dev-web.public_ip
}