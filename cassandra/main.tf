provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "${var.cred_file}"
}

# elastic ip
data "aws_eip" "elip" {
    tags = {
      name = "cassandra"
    }
}

resource "aws_eip_association" "cassandra_eip" {
  instance_id = "${aws_instance.cassandra.id}"
  allocation_id = "${data.aws_eip.elip.id}" 
}

# output

output "ip" {
  value = "${aws_instance.cassandra.public_ip}"
  description = "Public ip address of instance"
}
output "eip" {
  value = "${data.aws_eip.elip.public_ip}"
  description = "Elastic ip address of instance"
}

# create new instances from ami
resource "aws_instance" "cassandra" {
  ami = "${lookup(var.ami, var.region)}"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  availability_zone = "${var.zones[0]}"

  tags = {
    name = "cassandra"
  }

  provisioner "file" {
    source = "./scripts/createCassandra.sh"
    destination = "/tmp/createCassandra.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/createCassandra.sh",
      "/tmp/createCassandra.sh",
    ]
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = "${var.user}"
    private_key = "${file("~/.ssh/${var.key_file}")}"
  }
}
