
provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "${var.cred_file}"
}

# get ebs volume by id
data "aws_ebs_volume" "web_vol" {
  most_recent = true
  filter {
    name = "volume-id"
    values = ["${var.volume_id}"] 
  }
}

# copy ebs volume into snapshot
resource "aws_ebs_snapshot" "web_snap" {
  volume_id = "${data.aws_ebs_volume.web_vol.id}"
}

# create ami from snapshot
resource "aws_ami" "web_ami" {
  name = "web_ami"
  virtualization_type = "hvm"
  root_device_name = "/dev/sda1"

  ebs_block_device {
    device_name = "/dev/sda1"
    snapshot_id = "${aws_ebs_snapshot.web_snap.id}"
  }
}

# get security group
data "aws_security_group" "web_server" {
  filter {
    name = "group-name"
    values = ["${var.security_name}"]
  }
}

# create instance w/ ami
resource "aws_instance" "web2" {
  ami = "${aws_ami.web_ami.id}"
  instance_type = "t2.micro"
  security_groups = ["${data.aws_security_group.web_server.name}"]
  key_name = "${var.key_name}"
}
