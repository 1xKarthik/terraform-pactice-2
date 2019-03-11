provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
  profile    = "${var.aws_profile}"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "web" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"

  provisioner "local-exec" {
    command = "echo ${aws_instance.web.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "eip" {
  instance = "${aws_instance.web.id}"
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.15.0"

  name                = "web-server"
  description         = "Security group for web-server with HTTP ports open within VPC"
  vpc_id              = "${data.aws_vpc.default.id}"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp"]
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["all-all"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
}

output "ip" {
  value = "${aws_eip.eip.public_ip}"
}

output "vpc" {
  value = "${data.aws_vpc.default.id}"
}
