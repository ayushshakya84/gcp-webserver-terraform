module "compute_engine" {
  source = "./modules/compute_engine"

  instances = {

    instance1 = {
      name               = "instance-1"
      zone               = "us-central1-a"
      machine_type       = "e2-medium"
      boot_disk_image    = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240731"
      boot_disk_type     = "pd-standard"
      boot_disk_size     = 10
      boot_disk_labels   = { env = "dev" }
      subnet_id          = module.virtual_network.subnet_id["subnetwork1"]
      tags               = ["web", "dev"]
      service_account_id = "my-custom-sa-1"
    }

    instance2 = {
      name             = "instance-2"
      zone             = "us-central1-a"
      machine_type     = "e2-medium"
      boot_disk_image  = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240731"
      boot_disk_type   = "pd-standard"
      boot_disk_size   = 20
      boot_disk_labels = { env = "prod" }
      subnet_id        = module.virtual_network.subnet_id["subnetwork1"]
      tags             = ["web", "prod"]

    }
  }
}

module "virtual_network" {
  source = "./modules/virtual_network"
  vpc = {

    vpc1 = {
      name                    = "my-vpc"
      auto_create_subnetworks = false
      mtu                     = 1400
    }

  }

  subnetwork = {

    subnetwork1 = {
      subnetwork_name   = "test-subnetwork"
      subnetwork_cidr   = "10.2.0.0/16"
      subnetwork_region = "us-central1"
      vpc_id            = "my-vpc"
    }

  }

  firewall = {

    firewall1 = {
      name          = "myfirewall"
      network       = "my-vpc"
      protocol      = "tcp"
      ports         = ["80", 22]
      source_ranges = ["0.0.0.0/0"]
      target_tags   = ["web"]
    }

  }
}

module "load_balancer" {
  source                   = "./modules/load_balancer"
  region                   = "us-central1"
  instance_group_self_link = module.compute_engine.instance_group_self_link
}