variable "region" { type = "list" }
variable "cred_file" {}
variable "ami_name" {}
variable "zones" { type = "list" }
variable "instance_id" {}
variable "security_name" {}
variable "key_name" {}
variable "profile" {
  default = "default"
}
