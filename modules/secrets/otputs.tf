output "secret" {
  value = google_secret_manager_secret_version.secret-version-basic.secret_data
}