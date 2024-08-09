variable "instances" {
  description = "Map of instance configurations"
  type = map(object({
    name               = string
    machine_type       = string
    boot_disk_image    = string
    boot_disk_type     = string
    zone               = string
    boot_disk_size     = number
    boot_disk_labels   = map(string)
    subnet_id          = string
    tags               = list(string)
    service_account_id = optional(string)
  }))
}