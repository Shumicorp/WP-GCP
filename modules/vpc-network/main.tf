resource "google_compute_network" "vpc_network" {
  name                    = "${var.name}-${var.prefix}-vpc"
  auto_create_subnetworks = "false"
}
resource "google_compute_subnetwork" "public-subnet" {
  name          = "${var.name}-${var.prefix}-public-subnet"
  ip_cidr_range = var.subnet1_ip_cidr
  region        = var.subnet1_region
  network       = google_compute_network.vpc_network.name
  depends_on    = [google_compute_network.vpc_network]
}
resource "google_compute_subnetwork" "private-subnet" {
  name                     = "${var.name}-${var.prefix}-private-subnet"
  ip_cidr_range            = var.subnet2_ip_cidr
  network                  = google_compute_network.vpc_network.name
  region                   = var.subnet2_region
  private_ip_google_access = "true"
  depends_on               = [google_compute_network.vpc_network]
}
resource "google_compute_router" "router" {
  name    = "${var.name}-${var.prefix}-router"
  network = google_compute_network.vpc_network.id
}
resource "google_compute_router_nat" "nat" {
  name                               = "${var.name}-${var.prefix}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}


