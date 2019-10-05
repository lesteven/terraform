provider "aws" {
  profile = "${var.profile}"
  region = "${var.region}"
  shared_credentials_file = "${var.cred_file}"
}

# get security group
data "aws_security_group" "web_server" {
  filter {
    name = "group-name"
    values = ["${var.security_name}"]
  }
}

#output
output "ip" {
  value = "${aws_instance.simple.public_ip}"
  description = "Public ip address of instance"
}

resource "aws_instance" "simple" {
  ami = "${lookup(var.ami, var.region)}"
  instance_type = "${var.instance_type}"
  security_groups = ["${data.aws_security_group.web_server.name}"]
  key_name = "${var.key_name}"
}
