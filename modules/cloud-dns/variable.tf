variable "ip" {
  type        = list(any)
  description = "ip-address from load balancer(front-service)"
}
variable "dns_name" {
  type = string
}
variable "dns_type" {
  type = string
}