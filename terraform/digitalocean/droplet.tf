resource "digitalocean_droplet" "prometheus-grafana" {
  image  = "centos-7-x64"
  name   = "prometheus-grafana"
  region = "lon1"
  size   = "s-4vcpu-8gb"
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]

  provisioner "remote-exec" {
    inline = ["sudo yum -y install python"]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.pvt_key}")}"
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u root --private-key ${var.pvt_key} ../../ansible/prometheus-grafana.yml -i ${self.ipv4_address},"
  }
}

resource "digitalocean_droplet" "node-1" {
  image  = "centos-7-x64"
  name   = "node-1"
  region = "lon1"
  size   = "s-4vcpu-8gb"
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]

  provisioner "remote-exec" {
    inline = ["sudo yum -y install python"]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.pvt_key}")}"
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u root --private-key ${var.pvt_key} ../../ansible/node-exporter.yml -i ${self.ipv4_address},"
  }
}