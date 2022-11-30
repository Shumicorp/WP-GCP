variable "length" {
  type = number
}
variable "secret_id" {
  type = string
}
variable "labels" {
  type = string
}
variable "min_upper" {
  type    = number
  default = 2
}
variable "min_lower" {
  type    = number
  default = 2
}
variable "min_numeric" {
  type    = number
  default = 2
}
variable "min_special" {
  type    = number
  default = 2
}