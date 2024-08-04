variable "region" {
  description = "The region where the load balancer resources will be created"
  type        = string
}

variable "instance_group_self_link" {
  description = "The self link of the instance group"
  type        = string
}
