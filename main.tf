terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}
# AWS Provider
provider "aws" {
    region = "us-east-1"  
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "devops_sg" {
    name = "devops_sg"
    description = "Security group for Devops project"

    ingress  {
        description = "Allow HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress  {
        description = "Allow SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Allow all outboud traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      name = "devops_sg"
    }
}

resource "aws_instance" "devops_server" {
    ami = "ami-0b6c6ebed2801a5cb"
    instance_type = "t3.micro"
    key_name = "devops-project-1"
    vpc_security_group_ids = [aws_security_group.devops_sg.id]

    user_data = file("install_docker.sh")

    tags = {
      Name = "DevOps-Flask-Server"
    }
  
}

resource "aws_eip" "devops_eip" {
  instance = aws_instance.devops_server.id
  domain = "vpc"

  tags = {
    Name = "DevOps-EIP"
  }
  
}
resource "aws_eip_association" "devops_eip_assoc" {
  instance_id   = aws_instance.devops_server.id
  allocation_id = aws_eip.devops_eip.id
}