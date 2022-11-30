variable "app_name" {
  type = string
}
variable "mig-id" {
  type        = string
  description = "id instance groupe"
}
variable "check" {
  type        = list(string)
  description = "health check"
}

variable "ssl-domains" {
  type    = list(any)
  default = []
}
