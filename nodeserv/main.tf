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


# create new instances from ami
resource "aws_instance" "webA" {
  ami = "${lookup(var.ami, var.region)}"
  instance_type = "t2.micro"
  security_groups = ["${data.aws_security_group.web_server.name}"]
  key_name = "${var.key_name}"
  availability_zone = "${var.zones[0]}"
}
