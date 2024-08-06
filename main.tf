module "compute_engine" {
  source = "./Modules/compute_engine"

  instances = {
    instance1 = {
      name               = "instance-1"
      zone               = "us-central1-a"
      machine_type       = "n1-standard-1"
      boot_disk_image    = "debian-cloud/debian-9"
      boot_disk_type     = "pd-standard"
      boot_disk_size     = 10
      boot_disk_labels   = { env = "dev" }
      subnet_id          = module.virtual_network.subnet_id["subnetwork1"]
      tags               = ["web", "dev"]
      service_account_id = "my-custom-sa-1"
    }
    instance2 = {
      name             = "instance-2"
      machine_type     = "n1-standard-2"
      zone             = "us-central1-b"
      boot_disk_image  = "debian-cloud/debian-10"
      boot_disk_type   = "pd-ssd"
      boot_disk_size   = 20
      boot_disk_labels = { env = "prod" }
      subnet_id        = module.virtual_network.subnet_id["subnetwork1"]
      tags             = ["web", "prod"]
    }
  }
}

module "virtual_network" {
  source = "./Modules/virtual_network"
  subnetwork = {
    subnetwork1 = {
      subnetwork_name   = "test-subnetwork"
      subnetwork_cidr   = "10.2.0.0/16"
      subnetwork_region = "us-central1"
      vpc_id = "default"
    }
  }

  vpc = {
    vpc1 = {
      name                    = "my-vpc"
      auto_create_subnetworks = false
      mtu                     = 11
    }
  }
}

module "load_balancer" {
  source                   = "./modules/load_balancer"
  region                   = "us-central1"
  instance_group_self_link = module.compute_engine.instance_group_self_link
}


output "load_balancer_ip" {
  value = module.load_balancer.load_balancer_ip
}