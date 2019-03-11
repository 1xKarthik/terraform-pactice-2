data "aws_ip_ranges" "ec2" {
  regions  = ["ap-south-1"]
  services = ["ec2"]
}

resource "aws_security_group" "myGroup" {
  name = "myGroupName"

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "MYGROUP"
    CreateDate = "${data.aws_ip_ranges.ec2.create_date}"
    SyncToken  = "${data.aws_ip_ranges.ec2.sync_token}"
  }
}
