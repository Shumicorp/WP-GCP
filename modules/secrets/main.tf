resource "random_password" "password" {
  length           = var.length
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_upper        = var.min_upper
  min_lower        = var.min_lower
  min_numeric      = var.min_numeric
  min_special      = var.min_special
}
resource "google_secret_manager_secret" "secret-basic" {
  secret_id = var.secret_id

  labels = {
    label = var.labels
  }

  replication {
    automatic = true
  }
}
resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret = google_secret_manager_secret.secret-basic.id

  secret_data = random_password.password.result
}