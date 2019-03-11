resource "aws_key_pair" "developer" {
  key_name   = "MY_KEY"
  public_key = "${file("${var.PUBLIC_KEY_PATH}")}"
}

resource "aws_instance" "example" {
  ami                    = "${lookup(var.AMIS, var.REGION)}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.developer.key_name}"
  vpc_security_group_ids = ["${aws_security_group.myGroup.id}"]

  provisioner "file" {
    source      = "inventory"
    destination = "/tmp/inventory"
  }

  provisioner "file" {
    source      = "provision.yml"
    destination = "/tmp/provision.yml"
  }

  # provisioner "file" {
  #   source      = "script.sh"
  #   destination = "/tmp/script.sh"
  # }

  provisioner "remote-exec" {
    # inline = [  #   "chmod +x /tmp/script.sh",  #   "sudo /tmp/script.sh"  # ]
    inline = [
      "sudo yum install python -y",
      "sudo amazon-linux-extras install ansible2 -y",
      "ansible-playbook -u ec2-user -i /tmp/inventory "
    ]
  }

  connection {
    type        = "ssh"
    user        = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u fedora -i '${self.public_ip},' --private-key ${file("${var.PRIVATE_KEY_PATH}")} provision.yml"
  }
}

output "ip" {
  value = "${aws_instance.example.public_ip}"
}
