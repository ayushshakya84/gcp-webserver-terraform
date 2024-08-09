resource "google_service_account" "custom" {
  for_each     = { for k, v in var.instances : k => v if v.service_account_id != null }
  account_id   = each.value.service_account_id
  display_name = "Custom Service Account for Instances"
  description  = "Service account for compute instances"
}

resource "google_compute_instance" "default" {
  for_each     = var.instances
  name         = each.value.name
  machine_type = each.value.machine_type
  zone         = each.value.zone

  tags = each.value.tags

  boot_disk {
    initialize_params {
      image  = each.value.boot_disk_image
      type   = each.value.boot_disk_type
      size   = each.value.boot_disk_size
      labels = each.value.boot_disk_labels
    }
  }

  network_interface {
    subnetwork = each.value.subnet_id
  }

  lifecycle {
    ignore_changes = [metadata]
  }

  metadata = {
    foo = "bar"
  }

  dynamic "service_account" {
    for_each = each.value.service_account_id != null ? [each.value] : []
    content {
      email  = google_service_account.custom[each.key].email
      scopes = ["cloud-platform"]
    }
  }
}

resource "google_compute_instance_group" "default" {
  name      = "instance-group"
  zone      = lookup(var.instances["instance1"], "zone", null)
  instances = [for instance in google_compute_instance.default : instance.self_link]
  named_port {
    name = "http"
    port = 80
  }
}
