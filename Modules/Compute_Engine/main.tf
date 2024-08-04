data "vault_kv_secret_v2" "github_token" {
  mount = "secret"
  name  = "github_token"
}

resource "google_service_account" "default" {
  account_id   = "my-custom-sa"
  display_name = "Custom SA for V Instance"
  description = "Service account for computer instances"
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

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance_group" "default" {
  name        = "instance-group"
  zone        =  lookup(var.instances["instance1"], "zone", null)
  instances   = [for instance in google_compute_instance.default : instance.self_link]
  named_port {
    name = "http"
    port = 80
  }
}
