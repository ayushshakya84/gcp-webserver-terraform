variable "vpc" {
  description = "The name of the vpc network"
  type = map(object({
    name                    = string
    auto_create_subnetworks = bool
    mtu                     = number
  }))
}

variable "subnetwork" {
  description = "The Name of the Subnetwork"
  type = map(object({
    subnetwork_name   = string
    subnetwork_cidr   = string
    subnetwork_region = string
    vpc_id            = string
  }))
}

variable "firewall" {
  description = "List of firewall rules"
  type = map(object({
    name          = string
    network       = string
    protocol      = string
    ports         = list(string)
    source_ranges = list(string)
    target_tags   = list(string)
  }))
}