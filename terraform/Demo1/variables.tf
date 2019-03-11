variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  type = "map"

  default = {
    "ap-south-1" = "ami-03103e7ded4c02ef8"
  }
}

variable "PUBLIC_KEY_PATH" {
  default = "C:/Users/Karthik/.ssh/id_rsa.pub"
}

variable "PRIVATE_KEY_PATH" {
  default = "C:/Users/Karthik/.ssh/id_rsa"
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}
