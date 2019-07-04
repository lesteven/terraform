variable "region" {
  default = "us-west-1"
}
variable "cred_file" {
  default = "~/.aws/credentials"
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
variable "key_file" {}
variable "dep_key" {}
variable "user" {
  default = "ubuntu"
}

variable "username" {}
variable "password" {}
variable "security_name" {}
