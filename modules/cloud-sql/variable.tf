variable "vpc_net" {
  description = "vpc-network"
}
variable "db_service_name" {
  type        = string
  description = "name database"
}
variable "prefix" {
  type = string
}
variable "region" {
  type = string
}
variable "zone1" {
  type = string
}
variable "zone2" {
  type = string
}
variable "database_version" {
  type = string
}
variable "deletion_protection" {
  type = string
}
variable "db_instance_type" {
  type = string
}
variable "db_user_name" {
  type = string
}
variable "db_user_pass" {
  type      = string
  sensitive = true
}
variable "db_database_name" {
  type = string
}
