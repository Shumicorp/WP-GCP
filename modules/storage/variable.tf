variable "bucket_name" {
  type        = string
  description = "name cloud storage-bucket"
}
variable "prefix" {
  type        = string
  description = "sufix for bucket"
}
variable "bucket_location" {
  type        = string
  description = "location for storage-bucket"
}
variable "sa" {
  type        = string
  description = "service account for access storage-bucket"
}
variable "bucket_sa_role" {
  type = string
}
variable "bucket_lifecycle_age" {
  type = number
}
variable "bucket_versioning" {
  type = string
}