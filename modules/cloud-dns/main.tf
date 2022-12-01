resource "google_dns_managed_zone" "parent-zone" {
  name        = "zone"
  dns_name    = "${var.dns-name}."
  description = "Terraform"
}

resource "google_dns_record_set" "resource-recordset" {
  managed_zone = google_dns_managed_zone.parent-zone.name
  name         = "${var.dns-name}."
  type         = var.dns-type
  rrdatas      = var.ip
  ttl          = 5
}