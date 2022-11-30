variable "project" {
  type = string
}
variable "account_id" {
  type = string
}
variable "roles" {
  type        = set(string)
  description = "roles"
}