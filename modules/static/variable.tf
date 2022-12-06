variable "app_name" {
  type = string
}
variable "ssl_domains" {
  type    = list(any)
  default = []
}