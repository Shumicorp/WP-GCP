variable "name" {
  type = string
}
variable "prefix" {
  type = string
}
variable "network" {
}
variable "subnet" {
}
variable "machine_type" {
  default = "f1-micro"
  type    = string
}
variable "zone" {
  type = string
}