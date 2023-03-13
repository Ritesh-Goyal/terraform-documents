terraform {
  backend "s3" {
    bucket = "ritesh-aws-infrastructure-tfstate"
    key    = "devops/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

output "amazon-ami" {
  value = data.aws_ami.amazon_linux_2.id
}

resource "aws_key_pair" "awsKey" {
  key_name   = "${terraform.workspace}-devops-serverKey-terraform22"
  public_key = file("id_rsa.pub")
}

resource "aws_instance" "instance01" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.awsKey.key_name
  tags = {
    Name = "${terraform.workspace}-terraform-example"
  }
  security_groups = ["${aws_security_group.AWSaccess.name}"]
}

resource "aws_security_group" "AWSaccess" {
  name        = "${terraform.workspace}-AWSaccess"
  description = "SSH access"
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}
