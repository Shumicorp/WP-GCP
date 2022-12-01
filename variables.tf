variable "project" {
  # for provider
  type        = string
  description = "your project id"
}
variable "region" {
  # for provider
  type        = string
  default     = "europe-west1"
  description = "your region"
}
variable "zone" {
  type    = string
  default = "zone1"
}
variable "secret_lenght" {
  type    = number
  default = 8
}

variable "secret_id" {
  type    = string
  default = "db-password"
}
variable "secret_labels" {
  type      = string
  default   = null
  sensitive = true
}

variable "vpc-subnet1-ip_cidr" {
  type        = string
  default     = "10.0.10.0/24"
  description = "IP range"
}
variable "vpc-subnet1-region" {
  type    = string
  default = "europe-west2"
}

variable "vpc-subnet2-ip_cidr" {
  type        = string
  default     = "10.0.20.0/24"
  description = "IP range"
}
variable "vpc-subnet2-region" {
  type    = string
  default = "europe-west1"
}

variable "firewall" {
  default = {
    rule = {
      name                    = "allow-bastion-ssh"
      description             = null
      direction               = "INGRESS"
      priority                = 1000
      target_tags             = null
      target_service_accounts = null
      destination_ranges      = null
      source_tags             = null
      source_service_accounts = null
      source_ranges           = ["0.0.0.0/0"]
      allow = [{
        ports    = ["22"]
        protocol = "TCP"
      }]
      deny = []
    }
  }

}

variable "account_id" {
  type        = string
  description = ""
  default     = "service-account"
}
variable "roles" {
  type        = set(string)
  description = "roles"
  default     = ["roles/iam.serviceAccountUser", "roles/compute.instanceAdmin.v1", "roles/iap.tunnelResourceAccessor"]
}
variable "app-name-sufix" {
  type        = string
  description = "sufix for bucket"
  default     = "prod"
}
variable "bucket-lifecycle-age" {
  type    = number
  default = 365
}
variable "bucket-versioning" {
  type    = string
  default = "true"
}
variable "bucket-location" {
  type        = string
  description = "location for storage-bucket"
  default     = "EU"
}
variable "bucket-sa-role" {
  type    = string
  default = "roles/storage.admin"
}

variable "db-service-name" {
  type    = string
  default = "wp-sql"
}
variable "db-region" {
  type    = string
  default = "europe-west1"
}
variable "db-zone1" {
  type    = string
  default = "b"
}
variable "db-zone2" {
  type    = string
  default = "c"
}
variable "database_version" {
  type    = string
  default = "MYSQL_5_7"
}
variable "deletion_protection" {
  type    = string
  default = "false"
}
variable "db-instance-type" {
  type    = string
  default = "db-f1-micro"
}
variable "db-user-name" {
  type        = string
  description = "user name"
  default     = "wordpress"
}

variable "db-database-name" {
  type    = string
  default = "wordpress"
}

variable "app_name" {
  type    = string
  default = "wordpress"
}
variable "source_image_packer" {
  type    = string
  default = "ubuntu-2004-focal-v20220419"
}
variable "ssh-private-key-path" {
  type = string
}
variable "ssh-username-packer" {
  type = string
}
variable "packer-machine-type" {
  type = string
}
variable "wp-playbook" {
  type = string
}
variable "mig_tags" {
  type    = list(string)
  default = ["app"]
}
variable "mig_machine_type" {
  type    = string
  default = "f1-micro"
}
variable "mig_distribution_policy_zones" {
  type    = list(any)
  default = ["europe-west1-d", "europe-west1-b", "europe-west1-c"]
}
variable "mig_port_name" {
  type    = string
  default = "http"
}
variable "mig_port" {
  type    = number
  default = 80
}
variable "auto_healing_delay" {
  type        = number
  default     = 300
  description = "initial_delay_sec for auto_healing_policies in mig"
}
variable "autoscaler-min" {
  type        = number
  default     = 2
  description = "number of minimum replicas for autoscaler"
}
variable "autoscaler-max" {
  type        = number
  default     = 4
  description = "number of maximum replicas for autoscaler"
}
variable "ssl_domains" {
  type = string
}
variable "dns-name" {
  type    = string
}
variable "dns-type" {
  type    = string
  default = "A"
}