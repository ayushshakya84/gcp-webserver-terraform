output "subnet_id" {
  description = "Subnet"
  value       = { for k, v in google_compute_subnetwork.network-with-public : k => v.id }
}

output "network_name" {
  description = "network"
  value       = { for k, v in google_compute_network.vpc_network : k => v.id }
}