module "compute_engine" {
  source = "./Modules/compute_engine"

  instances = {
    instance1 = {
      name             = "instance-1"
      zone             = "us-central1-a"
      machine_type     = "n1-standard-1"
      boot_disk_image  = "debian-cloud/debian-9"
      boot_disk_type   = "pd-standard"
      boot_disk_size   = 10
      boot_disk_labels = { env = "dev" }
      subnet_id        = module.virtual_network.subnet_id
      tags             = ["web", "dev"]
    }
    instance2 = {
      name             = "instance-2"
      machine_type     = "n1-standard-2"
      zone             = "us-central1-b"
      boot_disk_image  = "debian-cloud/debian-10"
      boot_disk_type   = "pd-ssd"
      boot_disk_size   = 20
      boot_disk_labels = { env = "prod" }
      subnet_id        = module.virtual_network.subnet_id
      tags             = ["web", "prod"]
    }
  }
}

module "virtual_network" {
  source           = "./Modules/virtual_network"
  network_name     = "vpc-network"
  subnetwork_name  = "test-subnetwork"
  subnetwork_cidr  = "10.2.0.0/16"
  region           = "us-central1"
  allow_ports      = ["80", "22"]
  source_ip_ranges = ["0.0.0.0/0"]

}

module "load_balancer" {
  source                   = "./modules/load_balancer"
  region                   = "us-central1"
  instance_group_self_link = module.compute_engine.instance_group_self_link
}


output "load_balancer_ip" {
  value = module.load_balancer.load_balancer_ip
}