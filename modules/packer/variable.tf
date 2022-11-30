variable "subnet" {
  type = string
}
variable "project" {
  type = string
}
variable "zone" {
  type = string
}
variable "app-name" {
  type = string
}
variable "app-name-sufix" {
  type = string
}
variable "source-image" {
  type = string
}
variable "bastion-ip" {
  type = string
}
variable "ssh-private-key-path" {
  type = string
}
variable "ssh-username" {
  type = string
}
variable "packer-machine-type" {
  type = string
}
variable "playbook" {
  type = string
}
variable "ansible-extra-vars" {
  type = string
}