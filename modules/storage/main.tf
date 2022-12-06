resource "google_storage_bucket" "wp-bucket" {
  name                        = "${var.bucket_name}-${var.prefix}-bucket"
  location                    = var.bucket_location
  uniform_bucket_level_access = true
  force_destroy               = true
  lifecycle_rule {
    condition {
      age = var.bucket_lifecycle_age
    }
    action {
      type = "Delete"
    }
  }
  versioning {
    enabled = var.bucket_versioning
  }
}

resource "google_storage_bucket_iam_member" "member" {
  bucket     = google_storage_bucket.wp-bucket.name
  role       = var.bucket_sa_role
  member     = "serviceAccount:${var.sa}"
  depends_on = [google_storage_bucket.wp-bucket]
}
