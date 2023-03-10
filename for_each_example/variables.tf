variable "region" {
  default = "ap-south-1"
}

variable "env_infra" {
  type = map
  default = {
    "dev" : "t2.nano",
    "stage" : "t2.micro",
    "prod" : "t2.medium"
  }
}