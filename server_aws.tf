terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.64.0"
    }
  }
}

provider "aws" {
region = "sa-east-1"
}
resource "aws_instance" "myawsserver" {
  ami = "ami-04d88e4b4e0a5db46"     #Ubuntu
  vpc_security_group_ids  = [aws_security_group.allow_ssh.id]
  instance_type = "t2.micro"
  key_name = "raman-import-test"

  tags = {
    Name = "raman-DevOps-batch-server"
    env = "Production"
    owner = "Raman"
  }
  provisioner "local-exec" {
    command = "echo The servers IP address is ${self.public_ip} && echo ${self.public_ip} > /tmp/inv"
  }
}

