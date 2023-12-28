# Define an AWS EC2 instance named "dev-inst"
resource "aws_instance" "dev-inst" {
  # Use the AMI specified in the variable for the given region
  ami                    = var.AMIS[var.REGION]
  
  # Specify the instance type as "t2.micro"
  instance_type          = "t2.micro"
  
  # Place the instance in the specified availability zone
  availability_zone      = var.ZONE1
  
  # Use the key pair created by AWS to secure SSH access
  key_name               = aws_key_pair.dev-key.key_name
  
  # Specify the security group(s) for the instance
  vpc_security_group_ids = ["sg-012781f04be49cf6a"]
  
  # Add tags to the instance for better identification
  tags = {
    Name    = "DevOpsHub"
    Project = "DevOps"
  }
  
  # Use a file provisioner to copy a local script ("web.sh") to the instance
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  # Use a remote-exec provisioner to execute commands on the instance
  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  # Define the connection settings for SSH
  connection {
    user        = var.USER
    private_key = file("devkey")
    
    # Use the public IP address of the instance for connection
    host        = self.public_ip
  }
}
