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
  value = "${aws_instance.drone.public_ip}"
  description = "Public ip address of instance"
}

# create new instances from ami
resource "aws_instance" "drone" {
  ami = "${lookup(var.ami, var.region)}"
  instance_type = "t2.micro"
  security_groups = ["${data.aws_security_group.web_server.name}"]
  key_name = "${var.key_name}"
  availability_zone = "${var.zones[0]}"

  provisioner "local-exec" {
    command = "echo ${aws_instance.drone.public_ip} > ./scripts/prov/ip.txt"
  }
  provisioner "file" {
    source = "./scripts/prov"
    destination = "./"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x ./prov/createSite.sh",
      "sudo ./prov/createSite.sh",
    ]
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = "${var.user}"
    private_key = "${file("~/.ssh/${var.key_file}")}"
  }
}
