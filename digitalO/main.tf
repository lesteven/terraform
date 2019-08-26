
provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "pd" {
  name = "digital key"
  public_key = "${file("~/.ssh/${var.ssh_pubkey}")}"
}

resource "digitalocean_floating_ip" "ip" {
  droplet_id = "${digitalocean_droplet.server.id}"
  region = "${digitalocean_droplet.server.region}"
}

# output
output "ip" {
  value = "${digitalocean_floating_ip.ip.ip_address}"
  description = "Floating IP"
}


resource "digitalocean_droplet" "server" {
  image = "ubuntu-18-04-x64"
  name = "server"
  region = "sfo2"
  size = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.pd.fingerprint}"]
}
