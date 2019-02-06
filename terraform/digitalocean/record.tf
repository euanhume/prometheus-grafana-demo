
# Create a new domain
resource "digitalocean_domain" "default" {
  name = "prometheus.example.com"
}

# Add a record to the domain
resource "digitalocean_record" "prometheus-grafana" {
  domain = "${digitalocean_domain.default.name}"
  type   = "A"
  name   = "prometheus-grafana"
  value  = "${digitalocean_droplet.prometheus-grafana.ipv4_address_private}"
}

# Output the FQDN for the record
output "fqdn" {
  value = "${digitalocean_record.prometheus-grafana.fqdn}"
}