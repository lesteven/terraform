
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "web" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
}

