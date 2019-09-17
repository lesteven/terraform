variable "region" {
    default = "us-west-1"
}
variable "cred_file" {
  default = "~/.aws/credentials"
}
variable "security_name" {
  default = "web_server"
}
variable "ami" {
  default = {
    us-west-1 = "ami-063aa838bd7631e0b"
  }
}
variable "key_name" {}
