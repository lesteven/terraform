
provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "pd" {
  name = "digital key"
  public_key = "${file("~/.ssh/${var.ssh_pubkey}")}"
}

#resource "digitalocean_floating_ip" "ip" {
#  region = "${digitalocean_droplet.server.region}"
#  droplet_id = "${digitalocean_droplet.server.id}"
#}
#
## output
#output "ip" {
#  value = "${digitalocean_floating_ip.ip.ip_address}"
#  description = "Floating IP"
#}

# output
output "ip" {
  value = "${digitalocean_droplet.server.ipv4_address}"
  description = "Floating IP"
}


resource "digitalocean_droplet" "server" {
  image = "ubuntu-18-04-x64"
  name = "server"
  region = "sfo2"
  size = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.pd.fingerprint}"]

  provisioner "local-exec" {
    command = "echo ${digitalocean_droplet.server.ipv4_address} > ./scripts/prov/ip.txt"
  }
  provisioner "file" {
    source = "./scripts/prov"
    destination = "./"
  }
  provisioner "remote-exec" {
    inline = [
      "git clone https://github.com/lesteven/jsProj.git",
      "chmod +x ./prov/createSite.sh",
      "sudo ./prov/createSite.sh",
    ]
  }
  connection {
    type = "ssh"
    host = self.ipv4_address
    user = "root"
    private_key = "${file("~/.ssh/${var.private_key}")}"
  }
}
