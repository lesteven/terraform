
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}


resource "aws_instance" "web" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"

  security_groups = ["${aws_security_group.web_server.name}"]

  provisioner "file" {
    source = "createSite.sh"
    destination = "/tmp/createSite.sh"
  }
  provisioner "file" {
    source = "example.com"
    destination = "~/example.com"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/createSite.sh",
      "sudo /tmp/createSite.sh"
    ]
  }
  connection {
    type = "ssh"
    user = "${var.user}"
    private_key = "${file("~/.ssh/${var.key_file}")}"
  }
}

