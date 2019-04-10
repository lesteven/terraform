
provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "${var.cred_file}"
}

# fetch ami from aws
data "aws_ami" "web_ami" {
  filter {
    name = "name"
    values = ["${var.ami_name}"]
  }
}

# fetch instance from aws
data "aws_instance" "webA" {

}

# create new instance from ami
resource "aws_instance" "webB" {

}

#create elastic load balancer w/ two availability zones
resource "aws_elb" "autoscale" {
  name = "autoscale"
  availability_zones = "${var.zones}"
  listener {

  }
  instances = ["${aws_instance.}"]
}
