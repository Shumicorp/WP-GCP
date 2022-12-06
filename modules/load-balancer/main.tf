
resource "google_compute_url_map" "default" {
  name            = "${var.app_name}-load-balancer"
  default_service = google_compute_backend_service.backend.id
}
resource "google_compute_backend_service" "backend" {
  backend {
    group           = var.mig_id
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
  name          = "${var.app_name}-backend"
  health_checks = var.check
}

resource "google_compute_target_https_proxy" "https-proxy" {
  name             = "target-https-proxy"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = var.ssl_id
}

resource "google_compute_global_forwarding_rule" "https-forward" {
  name       = "https-front"
  ip_address = var.front_ip
  port_range = "443"
  target     = google_compute_target_https_proxy.https-proxy.id
}

resource "google_compute_target_http_proxy" "http-proxy" {
  name    = "target-http-proxy"
  url_map = google_compute_url_map.default.id
  #url_map = google_compute_url_map.http-redirect.id
}


resource "google_compute_global_forwarding_rule" "http-forward" {
  name       = "http-rule"
  ip_address = var.front_ip
  target     = google_compute_target_http_proxy.http-proxy.id
  port_range = "80"
}

/*
resource "google_compute_url_map" "http-redirect" {
  name = "http-redirect"
  default_url_redirect {
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
    https_redirect         = true
  }
}
*/