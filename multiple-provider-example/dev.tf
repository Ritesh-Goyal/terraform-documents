provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "dev_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

output "dev_amazon-ami" {
  value = data.aws_ami.dev_amazon_linux_2.id
}

resource "aws_instance" "dev_instance" {
  ami           = data.aws_ami.dev_amazon_linux_2.id
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-example"
  }
  security_groups = ["${aws_security_group.dev_AWSaccess.name}"]
}

resource "aws_security_group" "dev_AWSaccess" {
  name        = "dev_AWSaccess"
  description = "SSH access"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

