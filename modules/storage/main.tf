resource "google_storage_bucket" "wp-bucket" {
  name                        = "${var.bucket_name}-${var.bucket-name-sufix}-bucket"
  location                    = var.bucket-location
  uniform_bucket_level_access = true
  force_destroy               = true
  lifecycle_rule {
    condition {
      age = var.bucket-lifecycle-age
    }
    action {
      type = "Delete"
    }
  }
  versioning {
    enabled = var.bucket-versioning
  }
}

resource "google_storage_bucket_iam_member" "member" {
  bucket     = google_storage_bucket.wp-bucket.name
  role       = var.bucket-sa-role
  member     = "serviceAccount:${var.sa}"
  depends_on = [google_storage_bucket.wp-bucket]
}
