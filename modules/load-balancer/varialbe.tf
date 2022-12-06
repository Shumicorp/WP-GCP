variable "app_name" {
  type = string
}
variable "mig_id" {
  type        = string
  description = "id instance groupe"
}
variable "check" {
  type        = list(string)
  description = "health check"
}

variable "front_ip" {
   type = string
}
variable "ssl_id" {
  type = list(string)
}