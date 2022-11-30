variable "name" {
  type = string
}
variable "app-name-sufix" {
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