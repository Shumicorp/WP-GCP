resource "google_dns_managed_zone" "parent-zone" {
  name        = "my-zone"
  dns_name    = "${var.dns_name}."
  description = "dns zone"
  dnssec_config {
    state = "on"
  }
  force_destroy = true
}

resource "google_dns_record_set" "resource-recordset" {
  managed_zone = google_dns_managed_zone.parent-zone.name
  name         = "${var.dns_name}."
  type         = var.dns_type
  rrdatas      = var.ip
  ttl          = 5
}
