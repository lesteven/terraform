
provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "${var.cred_file}"
}

#resource "aws_ebs_volume" "web_vol" {
#  availability_zone = "us-west-1a"
#  volume_id = "${var.volume_id}"
#}
#
#resource "aws_ebs_snapshot" "web_snap" {
#  volume_id = "${aws_ebs_volume.web_vol.id}"
#}

resource "aws_instance" "example" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
}
