resource "google_compute_instance_template" "wp-template" {
  name           = "${var.app_name}-${var.app-name-sufix}-template"
  tags           = var.tags
  machine_type   = var.mig_machine_type
  can_ip_forward = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = "${var.app_name}-${var.app-name-sufix}-image"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = var.vpc
    subnetwork = var.sub-net
  }

  service_account {
    email  = var.sa
    scopes = ["cloud-platform"]
  }
  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
  metadata_startup_script = var.startup_script
}
resource "google_compute_region_instance_group_manager" "mig" {
  name                      = "${var.app_name}-${var.app-name-sufix}-mig"
  base_instance_name        = "${var.app_name}-${var.app-name-sufix}-groupe"
  region                    = var.mig-region
  distribution_policy_zones = var.distribution_policy_zones
  version {
    instance_template = google_compute_instance_template.wp-template.id
  }

  named_port {
    name = var.mig_port_name
    port = var.mig_port
  }
  auto_healing_policies {
    health_check      = google_compute_health_check.health-check.id
    initial_delay_sec = var.auto_healing_delay

  }
}
resource "google_compute_region_autoscaler" "autoscaler" {
  name   = "${var.app_name}-${var.app-name-sufix}-autoscaler"
  region = var.mig-region

  target = google_compute_region_instance_group_manager.mig.id
  autoscaling_policy {
    max_replicas    = var.autoscaler-max
    min_replicas    = var.autoscaler-min
    cooldown_period = 80
    cpu_utilization { target = 1 }
  }
}


resource "google_compute_health_check" "health-check" {
  name                = "${var.app_name}-${var.app-name-sufix}-health-check"
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 4

  tcp_health_check {
    port = var.mig_port
  }
}



