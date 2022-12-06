output "health_check" {
  value = google_compute_health_check.health-check.id
}
output "mig_id" {
  value = google_compute_region_instance_group_manager.mig.instance_group
}