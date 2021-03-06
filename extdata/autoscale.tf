
# no alias, b/c need default
provider "aws" {
  region = "${var.region[0]}"
  shared_credentials_file = "${var.cred_file}"
}

provider "aws" {
  alias = "${var.region[1]}"
  region = "${var.region[1]}"
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


# create new instances from ami
resource "aws_instance" "webA" {
  ami = "${data.aws_ami.web_ami.id}"
  instance_type = "t2.micro"
  security_groups = ["${data.aws_security_group.web_server.name}"]
  key_name = "${var.key_name}"
  availability_zone = "${var.zones[0]}"
}

resource "aws_instance" "webB" {
  ami = "${data.aws_ami.web_ami.id}"
  instance_type = "t2.micro"
  security_groups = ["${data.aws_security_group.web_server.name}"]
  key_name = "${var.key_name}"
  availability_zone = "${var.zones[1]}"
}

# output for instance public ips
output "webA_ip" {
  value = "${aws_instance.webA.public_ip}"
  description = "Public ip for webA"
}
output "webB_ip" {
  value = "${aws_instance.webB.public_ip}"
  description = "Public ip for webB"
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
    "${aws_instance.webA.id}", 
    "${aws_instance.webB.id}"
  ]
}

