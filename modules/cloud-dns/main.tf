resource "google_dns_managed_zone" "parent-zone" {
  count       =  var.new_zone == "true" ? 1 : 0
  name        = var.dns_name
  dns_name    = "${var.domain}."
  description = "dns zone"
  dnssec_config {
    state = "on"
  }
  force_destroy = true
}

resource "google_dns_record_set" "resource-recordset" {
  managed_zone = var.new_zone == "true" ? google_dns_managed_zone.parent-zone[0].name : var.dns_name
  name         = "${var.domain}."
  type         = var.dns_type
  rrdatas      = var.ip
  ttl          = 300
}

resource "google_dns_record_set" "dns-cname-record" {
  managed_zone = var.new_zone == "true" ? google_dns_managed_zone.parent-zone[0].name : var.dns_name
  name         = "www.${var.domain}."
  type         = "CNAME"
  rrdatas      = ["${var.domain}."]
  ttl          = 300
}