output "subnet_id" {
  description = "Subnet"
  value = google_compute_subnetwork.network-with-public.id
}

output "network_name" {
  description = "network"
  value = google_compute_network.vpc_network.name
}