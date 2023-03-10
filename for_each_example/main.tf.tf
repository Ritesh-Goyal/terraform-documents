resource "aws_instance" "instance01" {
  for_each = var.env_infra
  ami           = "ami-09ba48996007c8b50"
  instance_type = each.value
  tags = {
    "Name"        = "${each.key}-devops"
    "environment" = each.key
  }
}