variable "vpc-net" {

  description = "vpc-network"
}
variable "db-service-name" {
  type        = string
  description = "name database"
}
variable "app-name-sufix" {
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
variable "db-instance-type" {
  type = string
}
variable "db-user-name" {
  type = string
}
variable "db-user-pass" {
  type      = string
  sensitive = true
}
variable "db-database-name" {
  type = string
}
