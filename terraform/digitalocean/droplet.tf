resource "digitalocean_droplet" "prometheus-grafana" {
  image  = "centos-7-x64"
  name   = "prometheus-grafana"
  region = "lon1"
  size   = "s-4vcpu-8gb"
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]

  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.ipv4_address}' -u root ../../ansible/prometheus-grafana.yml --private-key ${var.pvt_key} -u root"
  }
}

resource "digitalocean_droplet" "node-1" {
  image  = "centos-7-x64"
  name   = "node-1"
  region = "lon1"
  size   = "s-4vcpu-8gb"
}