# output "vm_public_ip" {
#   value = [for instance in google_compute_instance.default : instance.network_interface[0].access_config[0].nat_ip]
# }

output "instance_group_self_link" {
  value = google_compute_instance_group.default.self_link
}