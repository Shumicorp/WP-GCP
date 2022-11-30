variable "network" {
  description = "Network value from the VPC module, append .id, etc to use in other resources"
}
variable "firewall" {
  type = map(object({
    name                    = string
    description             = string
    direction               = string
    priority                = number
    target_tags             = list(string)
    target_service_accounts = list(string)
    destination_ranges      = list(string)
    source_ranges           = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny = list(object({
      protocol = string
      ports    = list(string)
    }))
  }))
  description = "The list of firewall rules"
}
