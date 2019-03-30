
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_vpc" "web_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "webint" {
  vpc_id = "${aws_vpc.web_vpc.id}"
}

resource "aws_route" "internet_access" {
  route_table_id = "${aws_vpc.web_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.webint.id}"
}

resource "aws_subnet" "websubnet" {
  vpc_id = "${aws_vpc.web_vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "web_server" {
  name = "web_server"
  description = "allow http and https"
  vpc_id = "${aws_vpc.web_vpc.id}"

  # ssh
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # https
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  # http
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"

  vpc_security_group_ids = ["${aws_security_group.web_server.id}"]
  subnet_id = "${aws_subnet.websubnet.id}"

  provisioner "file" {
    source = "createSite.sh"
    destination = "/tmp/createSite.sh"
  }
  provisioner "file" {
    source = "example.com"
    destination = "~/example.com"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/createSite.sh",
      "sudo /tmp/createSite.sh"
    ]
  }
  connection {
    type = "ssh"
    user = "${var.user}"
    private_key = "${file("~/.ssh/${var.key_file}")}"
  }
}

