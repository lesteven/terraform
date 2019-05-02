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

  provisioner "local-exec" {
    command = "echo ${aws_instance.node_serv.public_ip} > ./scripts/prov/ip.txt",
  }
  provisioner "file" {
    source = "./scripts/prov"
    destination = "./"
  }
  provisioner "file" {
    source = "~/.ssh/${var.dep_key}"
    destination = "~/.ssh/${var.dep_key}"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 600 ~/.ssh/${var.dep_key}",
      "eval '$(ssh-agent -s)'",
      "ssh-add ~/.ssh/${var.dep_key}",
      "cat ./prov/githubKey >> ~/.ssh/known_hosts",
      "git clone git@github.com:lesteven/nodeServer.git",
      "chmod +x ./prov/createSite.sh",
      "sudo ./prov/createSite.sh",
    ]
  }
  connection {
    type = "ssh"
    user = "${var.user}"
    private_key = "${file("~/.ssh/${var.key_file}")}"
  }
}
