provider "aws" {
  alias   = "prod"
  region  = "us-west-1"
  profile = "prod"
}


data "aws_ami" "prod_amazon_linux_2" {
  provider    = aws.prod
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

output "prod_amazon-ami" {
  value = data.aws_ami.prod_amazon_linux_2.id
}

resource "aws_instance" "prod_instance" {
  provider      = aws.prod
  ami           = data.aws_ami.prod_amazon_linux_2.id
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-example"
  }
  security_groups = ["${aws_security_group.prod_AWSaccess.name}"]
}

resource "aws_security_group" "prod_AWSaccess" {
  provider    = aws.prod
  name        = "prod_AWSaccess"
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