
provider "aws" {
  region     = "${var.region}"
  shared_credentials_file = "${var.cred_file}"
}

# get security group
data "aws_security_group" "web_server" {
  filter {
    name = "group-name"
    values = ["${var.security_name}"]
  }
}

resource "aws_instance" "ruby" {
  ami = "${lookup(var.ami, var.region)}"
  key_name = "${var.key_name}"
  instance_type = "t2.micro"

  connection {
    type = "ssh"
    host = self.public_ip
    user = "${var.user}"
    private_key = "${file("~/.ssh/${var.key_name}.pem")}"
  }
}


#output
output "ip" {
  value = "${aws_instance.ruby.public_ip}"
  description = "Public ip address of instance"
}
