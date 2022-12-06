variable "app_name" {
  type = string
}
variable "prefix" {
  type = string
}
variable "tags" {
  type = list(string)
}
variable "mig_machine_type" {
  type = string
}
variable "vpc" {
  type        = string
  description = "id vpc-network"
}
variable "sub_net" {
  type        = string
  description = "id private-subnetwork"
}
variable "sa" {
  type        = string
  description = "service account for API access"
}
variable "startup_script" {
}
variable "mig_region" {
  type = string
}
variable "distribution_policy_zones" {
  type    = list(any)
  default = []
}
variable "mig_port_name" {
  type = string
}
variable "mig_port" {
  type = number
}
variable "auto_healing_delay" {
  type = number
}
variable "autoscaler_min" {
  type = number
}
variable "autoscaler_max" {
  type = number
}

