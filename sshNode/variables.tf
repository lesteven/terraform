variable "profile" {
  default = "default"
}
variable "region" {
  default = "us-west-1"
}
variable "cred_file" {
  default = "~/.aws/credentials"
}
variable "security_name" {
  default = "web_server"
}

variable "zones" {
  default = ["us-west-1a","us-west-1b"]
}
variable "ami" {
  default = {
    us-west-1 = "ami-063aa838bd7631e0b"
  }
}

variable "key_name" {}
variable "user" {
  default = "ubuntu"
}
variable "instance_type" {
  default = "t2.micro"
}
