variable "access_key" {}

variable "secret_key" {}

variable "region" {
  default = "ap-south-1"
}

variable "aws_profile" {
  default = "terraform"
}

variable "amis" {
  type = "map"

  default = {
    "ap-south-1" = "ami-03103e7ded4c02ef8"
  }
}

variable "instance_type" {
  default = "t2.micro"
}
