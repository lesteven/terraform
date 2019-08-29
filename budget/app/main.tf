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

# elastic ip
data "aws_eip" "elip" {
    tags = {
      name = "budget"
    }
}

resource "aws_eip_association" "budget_eip" {
  instance_id = "${aws_instance.budget.id}"
  allocation_id = "${data.aws_eip.elip.id}" 
}

#output
output "ip" {
  value = "${aws_instance.budget.public_ip}"
  description = "Public ip address of instance"
}

output "eip" {
  value = "${data.aws_eip.elip.public_ip}"
  description = "Elastic ip address of instance"
}

resource "aws_instance" "budget" {
  ami = "${lookup(var.ami, var.region)}"
  instance_type = "${var.instance_type}"
  security_groups = ["${data.aws_security_group.web_server.name}"]
  key_name = "${var.key_name}"
  

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
    private_key = "${file("~/.ssh/${var.key_name}.pem")}"
  }
}
