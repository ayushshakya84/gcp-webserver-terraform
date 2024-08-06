resource "google_compute_network" "vpc_network" {
  for_each                = var.vpc
  name                    = each.value.name
  auto_create_subnetworks = each.value.auto_create_subnetworks
  mtu                     = each.value.mtu
}

resource "google_compute_subnetwork" "network-with-public" {
  for_each      = var.subnetwork
  name          = each.value.subnetwork_name
  region        = each.value.subnetwork_region
  ip_cidr_range = each.value.subnetwork_cidr
  network       = each.value.vpc_id
  depends_on = [ google_compute_network.vpc_network ]
}


resource "google_compute_firewall" "default" {
  for_each = var.vpc
  name     = "default-firewall"
  network  = google_compute_network.vpc_network[each.key].self_link
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

