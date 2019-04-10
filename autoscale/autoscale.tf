
provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "${var.cred_file}"
}

# fetch ami from aws
data "aws_ami" "web_ami" {
  owners = ["self"]
  filter {
    name = "name"
    values = ["${var.ami_name}"]
  }
}

# get security group
data "aws_security_group" "web_server" {
  filter {
    name = "group-name"
    values = ["${var.security_name}"]
  }
}

# fetch instance from aws
data "aws_instance" "webA" {
  instance_id = "${var.instance_id}"
}

# create new instance from ami
resource "aws_instance" "webB" {
  ami = "${data.aws_ami.web_ami.id}"
  instance_type = "t2.micro"
  security_groups = ["${data.aws_security_group.web_server.name}"]
  key_name = "${var.key_name}"
  availability_zone = "${var.zones[1]}"
}

#create elastic load balancer w/ two availability zones
resource "aws_elb" "autoscale" {
  name = "autoscale"
  availability_zones = "${var.zones}"
  listener {
    instance_port = 80
    instance_protocol = "http" 
    lb_port = 80
    lb_protocol = "http"
  }
  instances = [
    "${data.aws_instance.webA.id}", 
    "${aws_instance.webB.id}"
  ]
}

