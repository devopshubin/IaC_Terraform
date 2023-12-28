
resource "aws_key_pair" "dev-key" {
  key_name   = "devkey"
  public_key = file("devkey.pub")
}

resource "aws_instance" "dev-inst" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.dev-key.key_name
  vpc_security_group_ids = ["sg-012781f04be49cf6a"]
  tags = {
    Name    = "DevOpsHub"
    Project = "DevOps"
  }
  
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  connection {
    user        = var.USER
    private_key = file("devkey")
    host        = self.public_ip
  }
}

output "PublicIP" {
  value = aws_instance.dev-inst.public_ip
}

output "PrivateIP" {
  value = aws_instance.dev-inst.private_ip
}