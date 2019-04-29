provider "aws" {
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

# output

output "ip" {
  value = "${aws_instance.node_serv.public_ip}"
  description = "Public ip address of instance"
}

# create new instances from ami
resource "aws_instance" "node_serv" {
  ami = "${lookup(var.ami, var.region)}"
  instance_type = "t2.micro"
  security_groups = ["${data.aws_security_group.web_server.name}"]
  key_name = "${var.key_name}"
  availability_zone = "${var.zones[0]}"

  provisioner "file" {
    source = "./nodeServer"
    destination = "./nodeServer"
  }

  provisioner "file" {
    source = "./scripts/createSite.sh"
    destination = "/tmp/createSite.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/createSite.sh",
    ]
  }
  connection {
    type = "ssh"
    user = "${var.user}"
    private_key = "${file("~/.ssh/${var.key_file}")}"
  }
}
