resource "random_id" "db_prefix" {
  byte_length = 4
}
resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_net.id
}
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.vpc_net.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
resource "google_service_networking_connection" "private_vpc_connection-backup" {
  network                 = var.vpc_net.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}


resource "google_sql_database_instance" "mysql" {
  name                = "${var.db_service_name}-${var.prefix}-master-${random_id.db_prefix.hex}"
  region              = var.region
  database_version    = var.database_version
  deletion_protection = var.deletion_protection
  settings {
    location_preference {
      zone = "${var.region}-${var.zone1}"
    }
    tier = var.db_instance_type
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_net.id
    }
    backup_configuration {
      binary_log_enabled = true
      enabled            = true
    }
  }
  depends_on = [google_service_networking_connection.private_vpc_connection]
}
resource "google_sql_database_instance" "mysql-backup" {
  name                 = "${var.db_service_name}-${var.prefix}-backup-${random_id.db_prefix.hex}"
  region               = var.region
  database_version     = var.database_version
  deletion_protection  = var.deletion_protection
  master_instance_name = google_sql_database_instance.mysql.name
  settings {
    location_preference {
      zone = "${var.region}-${var.zone2}"
    }
    tier = var.db_instance_type
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_net.id
    }
  }
  replica_configuration {
    failover_target = true
  }

  depends_on = [google_service_networking_connection.private_vpc_connection-backup]
}
resource "google_sql_user" "users" {
  name       = var.db_user_name
  instance   = google_sql_database_instance.mysql.name
  host       = "%"
  password   = var.db_user_pass
  depends_on = [google_sql_database_instance.mysql]
}
resource "google_sql_database" "database" {
  name       = var.db_database_name
  instance   = google_sql_database_instance.mysql.name
  depends_on = [google_sql_database_instance.mysql]
}



