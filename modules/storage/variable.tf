variable "bucket_name" {
  type        = string
  description = "name cloud storage-bucket"
}
variable "bucket-name-sufix" {
  type        = string
  description = "sufix for bucket"
}
variable "bucket-location" {
  type        = string
  description = "location for storage-bucket"
}
variable "sa" {
  type        = string
  description = "service account for access storage-bucket"
}
variable "bucket-sa-role" {
  type = string
}
variable "bucket-lifecycle-age" {
  type = number
}
variable "bucket-versioning" {
  type = string
}