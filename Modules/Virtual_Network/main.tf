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
  depends_on    = [google_compute_network.vpc_network]
}


resource "google_compute_firewall" "default" {
  for_each = var.firewall
  name     = each.value.name
  network  = each.value.network
  dynamic "allow" {
    for_each = var.firewall
    content {
      protocol = each.value.protocol
      ports    = each.value.ports
    }
  }

  source_ranges = each.value.source_ranges
  target_tags   = each.value.target_tags
}

