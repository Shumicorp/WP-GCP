resource "google_compute_instance" "bastion" {
  name         = "${var.name}-${var.app-name-sufix}-bastion"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["bastion"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  network_interface {
    network    = var.network.id
    subnetwork = var.subnet.id
    access_config {
      network_tier = "STANDARD"
    }
  }
  metadata_startup_script = <<SCRIPT
sudo cat << EOF >> /etc/ssh/sshd_config
    PermitTTY no
    X11Forwarding no
    PermitTunnel no
    GatewayPorts no
    ForceCommand /usr/sbin/nologin
EOF
sudo systemctl restart sshd.service
SCRIPT
}