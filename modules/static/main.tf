resource "google_compute_global_address" "front" {
  name = "static-ip"
}

resource "google_compute_managed_ssl_certificate" "default" {
  name = "${var.app_name}-ssl-certificate"
  managed {
    domains = var.ssl_domains
  }
}