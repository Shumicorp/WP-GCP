resource "google_service_account" "service-account" {
  account_id   = var.account_id
  display_name = "service-account"
}

resource "google_project_iam_member" "project" {
  for_each = var.roles
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.service-account.email}"
}

