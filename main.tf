# Example demonstrating various Terraform features

resource "aws_instance" "example" {
  ami           = "ami-0c94855ba95f83e8f" # Replace with your desired AMI
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #  Replace with a more restrictive CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "region" {
  type = string
  default = "us-west-2"
}

provider "aws" {
  region = var.region
}



output "instance_public_ip" {
  value = aws_instance.example.public_ip
}

output "instance_id" {
  value = aws_instance.example.id
}