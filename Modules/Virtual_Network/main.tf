resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "network-with-public" {
  name          = var.network_name
  ip_cidr_range = var.subnetwork_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}


resource "google_compute_firewall" "default" {
  name    = "default-firewall"
  network = google_compute_network.vpc_network.name
  dynamic "allow" {
    for_each = var.allow_ports
    iterator = port
    content {
      protocol = "tcp"
      ports    = [port.value]
    }
  }

  source_ranges = var.source_ip_ranges
}

