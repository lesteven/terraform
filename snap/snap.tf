
provider "aws" {
  region = "${var.region}"
  assume_role {
    role_arn = "${var.role_arn}"
  }
}

resource "aws_instance" "example" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
}
