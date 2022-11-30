resource "google_compute_global_address" "front" {
  name = "${var.app_name}-front"
}

resource "google_compute_backend_service" "backend" {
  backend {
    group           = var.mig-id
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
  name          = "${var.app_name}-backend"
  health_checks = var.check
}

resource "google_compute_url_map" "default" {
  name            = "${var.app_name}-url-map"
  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_target_https_proxy" "https-proxy" {
  name             = "${var.app_name}-proxy"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

resource "google_compute_managed_ssl_certificate" "default" {
  name = "${var.app_name}-ssl-certificate"
  managed {
    domains = var.ssl-domains
  }
}

resource "google_compute_global_forwarding_rule" "load-balancer-https" {
  name       = "https-role"
  ip_address = google_compute_global_address.front.address
  port_range = "443"
  target     = google_compute_target_https_proxy.https-proxy.id
}

resource "google_compute_target_http_proxy" "http-proxy" {
  name        = "${var.app_name}-target-http-proxy"
  url_map     = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "http-role" {
  name       = "${var.app_name}-http-rule"
  ip_address = google_compute_global_address.front.address
  target     = google_compute_target_http_proxy.http-proxy.id
  port_range = "80"
}