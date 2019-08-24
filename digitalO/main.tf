
provider "digitalocean" {
  token = "${var.do_token}"
}
resource "digitalocean_droplet" "server" {
  image = "ubuntu-18-04-x64"
  name = "server"
  region = "sfo2"
  size = "s-1vcpu-1gb"
}
