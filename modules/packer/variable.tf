variable "subnet" {
  type = string
}
variable "project" {
  type = string
}
variable "zone" {
  type = string
}
variable "app_name" {
  type = string
}
variable "prefix" {
  type = string
}
variable "source_image" {
  type = string
}
variable "bastion_ip" {
  type = string
}
variable "ssh_private_key_path" {
  type = string
}
variable "ssh_username" {
  type = string
}
variable "packer_machine_type" {
  type = string
}
variable "playbook" {
  type = string
}
variable "ansible_extra_vars" {
  type = string
}