
provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "${var.cred_file}"
}

data "aws_ebs_volume" "web_vol" {
  most_recent = true
  filter {
    name = "volume-id"
    values = ["${var.volume_id}"] 
  }
}

resource "aws_ebs_snapshot" "web_snap" {
  volume_id = "${data.aws_ebs_volume.web_vol.id}"
}

