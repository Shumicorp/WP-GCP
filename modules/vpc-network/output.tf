output "vpc" { # output id network outside for ather module
  value = google_compute_network.vpc_network
}
output "private_subnet" { # output id network outside for ather module
  value = google_compute_subnetwork.private-subnet
}
output "public_subnet" { # output id network outside for ather module
  value = google_compute_subnetwork.public-subnet
}
