
output "front_ip" { # output id network outside for ather module
  value = google_compute_global_address.front.address
}
output "ssl_id" { # output id network outside for ather module
  value = google_compute_managed_ssl_certificate.default.id
}