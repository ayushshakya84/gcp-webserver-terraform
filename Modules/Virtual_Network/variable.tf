variable "vpc" {
  description = "The name of the vpc network"
  type = map(object({
    name = string
    auto_create_subnetworks = bool
    mtu = number
  }))
}

variable "subnetwork_name" {
  description = "The Name of the Subnetwork"
  type = string
}

variable "subnetwork_cidr" {
  description = "The CIDR rage of the subnetwork"
  type = string
}

variable "region" {
  description = "The region where the network resources will be created"
  type = string
}

variable "allow_ports" {
  description = "List of ports to allow in the firewall"
  type = list(string)
  default = ["80", "22"]
}
variable "source_ip_ranges" {
  description = "List of ip to allow in the firewall"
  type = list(string)
  default = ["0.0.0.0/0"]
}