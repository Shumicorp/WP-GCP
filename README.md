# Terraform-gcp
Provider variables in the terraform.tfvars file

# My file to create infrastructure for wordpress app
necessary api access:   
  Identity and Access Management (IAM) API   
  Cloud Resource Manager API   
  Service Networking API   
  Cloud SQL Admin API   
  Cloud DNS API   
# Create: 
# VPC network - module "vpc_network":
  2 - subnetwork   
  cloud-nat     
# SQL - module "db_mysql"
  user   
  database   

# Service account - module "service-account"

# Cloud Storage - module "storage-bucket"
  storage   
  add service account with admin role

# Packer to create image using ansible
  image with:
    apache2   
    php   
    gcsfuse   
    add service account for access to Cloud Storage

# Compute Engine - Instance template - module "instance-template"
  template with start-script for mount cloud strage
     
# Compute Engine - Instance groups - module "instance-groupe"
  instance group   
  autoscaler   
  health-check   

# Network services - Load balancing - module "load-balancer"

# Cloud DNS


## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./modules/bastion | n/a |
| <a name="module_db_mysql"></a> [db\_mysql](#module\_db\_mysql) | ./modules/cloud-sql | n/a |
| <a name="module_dns"></a> [dns](#module\_dns) | ./modules/cloud-dns | n/a |
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ./modules/firewall | n/a |
| <a name="module_load-balancer"></a> [load-balancer](#module\_load-balancer) | ./modules/load-balancer | n/a |
| <a name="module_mig"></a> [mig](#module\_mig) | ./modules/mig | n/a |
| <a name="module_packer"></a> [packer](#module\_packer) | ./modules/packer/ | n/a |
| <a name="module_secret_manager"></a> [secret\_manager](#module\_secret\_manager) | ./modules/secrets | n/a |
| <a name="module_service_account"></a> [service\_account](#module\_service\_account) | ./modules/service-account | n/a |
| <a name="module_static"></a> [static](#module\_static) | ./modules/static | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./modules/storage | n/a |
| <a name="module_vpc_network"></a> [vpc\_network](#module\_vpc\_network) | ./modules/vpc-network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `string` | `"service-account"` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | n/a | `string` | `"wordpress"` | no |
| <a name="input_app_name_prefix"></a> [app\_name\_prefix](#input\_app\_name\_prefix) | prefix | `string` | `"prod"` | no |
| <a name="input_auto_healing_delay"></a> [auto\_healing\_delay](#input\_auto\_healing\_delay) | initial\_delay\_sec for auto\_healing\_policies in mig | `number` | `300` | no |
| <a name="input_autoscaler_max"></a> [autoscaler\_max](#input\_autoscaler\_max) | number of maximum replicas for autoscaler | `number` | `4` | no |
| <a name="input_autoscaler_min"></a> [autoscaler\_min](#input\_autoscaler\_min) | number of minimum replicas for autoscaler | `number` | `1` | no |
| <a name="input_bucket_lifecycle_age"></a> [bucket\_lifecycle\_age](#input\_bucket\_lifecycle\_age) | n/a | `number` | `365` | no |
| <a name="input_bucket_location"></a> [bucket\_location](#input\_bucket\_location) | location for storage-bucket | `string` | `"EU"` | no |
| <a name="input_bucket_sa_role"></a> [bucket\_sa\_role](#input\_bucket\_sa\_role) | n/a | `string` | `"roles/storage.admin"` | no |
| <a name="input_bucket_versioning"></a> [bucket\_versioning](#input\_bucket\_versioning) | n/a | `string` | `"true"` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | n/a | `string` | `"MYSQL_5_7"` | no |
| <a name="input_db_database_name"></a> [db\_database\_name](#input\_db\_database\_name) | n/a | `string` | `"wordpress"` | no |
| <a name="input_db_instance_type"></a> [db\_instance\_type](#input\_db\_instance\_type) | n/a | `string` | `"db-f1-micro"` | no |
| <a name="input_db_region"></a> [db\_region](#input\_db\_region) | n/a | `string` | `"europe-west1"` | no |
| <a name="input_db_service_name"></a> [db\_service\_name](#input\_db\_service\_name) | n/a | `string` | `"wp-sql"` | no |
| <a name="input_db_user_name"></a> [db\_user\_name](#input\_db\_user\_name) | user name | `string` | `"wordpress"` | no |
| <a name="input_db_zone1"></a> [db\_zone1](#input\_db\_zone1) | n/a | `string` | `"b"` | no |
| <a name="input_db_zone2"></a> [db\_zone2](#input\_db\_zone2) | n/a | `string` | `"c"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | n/a | `string` | `"false"` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | n/a | `string` | n/a | yes |
| <a name="input_dns_type"></a> [dns\_type](#input\_dns\_type) | n/a | `string` | `"A"` | no |
| <a name="input_firewall"></a> [firewall](#input\_firewall) | n/a | `map` | <pre>{<br>  "rule": {<br>    "allow": [<br>      {<br>        "ports": [<br>          "22"<br>        ],<br>        "protocol": "TCP"<br>      }<br>    ],<br>    "deny": [],<br>    "description": null,<br>    "destination_ranges": null,<br>    "direction": "INGRESS",<br>    "name": "allow-bastion-ssh",<br>    "priority": 1000,<br>    "source_ranges": [<br>      "0.0.0.0/0"<br>    ],<br>    "source_service_accounts": null,<br>    "source_tags": null,<br>    "target_service_accounts": null,<br>    "target_tags": null<br>  }<br>}</pre> | no |
| <a name="input_mig_distribution_policy_zones"></a> [mig\_distribution\_policy\_zones](#input\_mig\_distribution\_policy\_zones) | n/a | `list(any)` | <pre>[<br>  "europe-west1-d",<br>  "europe-west1-b",<br>  "europe-west1-c"<br>]</pre> | no |
| <a name="input_mig_machine_type"></a> [mig\_machine\_type](#input\_mig\_machine\_type) | n/a | `string` | `"f1-micro"` | no |
| <a name="input_mig_port"></a> [mig\_port](#input\_mig\_port) | n/a | `number` | `80` | no |
| <a name="input_mig_port_name"></a> [mig\_port\_name](#input\_mig\_port\_name) | n/a | `string` | `"http"` | no |
| <a name="input_mig_tags"></a> [mig\_tags](#input\_mig\_tags) | n/a | `list(string)` | <pre>[<br>  "app"<br>]</pre> | no |
| <a name="input_packer_machine_type"></a> [packer\_machine\_type](#input\_packer\_machine\_type) | n/a | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | your project id | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | your region | `string` | `"europe-west1"` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | roles | `set(string)` | <pre>[<br>  "roles/iam.serviceAccountUser",<br>  "roles/compute.instanceAdmin.v1",<br>  "roles/iap.tunnelResourceAccessor"<br>]</pre> | no |
| <a name="input_secret_id"></a> [secret\_id](#input\_secret\_id) | n/a | `string` | `"db-password"` | no |
| <a name="input_secret_labels"></a> [secret\_labels](#input\_secret\_labels) | n/a | `string` | `null` | no |
| <a name="input_secret_lenght"></a> [secret\_lenght](#input\_secret\_lenght) | n/a | `number` | `8` | no |
| <a name="input_source_image_packer"></a> [source\_image\_packer](#input\_source\_image\_packer) | n/a | `string` | `"ubuntu-2004-focal-v20220419"` | no |
| <a name="input_ssh_private_key_path"></a> [ssh\_private\_key\_path](#input\_ssh\_private\_key\_path) | n/a | `string` | n/a | yes |
| <a name="input_ssh_username_packer"></a> [ssh\_username\_packer](#input\_ssh\_username\_packer) | n/a | `string` | n/a | yes |
| <a name="input_ssl_domains"></a> [ssl\_domains](#input\_ssl\_domains) | n/a | `string` | n/a | yes |
| <a name="input_vpc_subnet1_ip_cidr"></a> [vpc\_subnet1\_ip\_cidr](#input\_vpc\_subnet1\_ip\_cidr) | IP range | `string` | `"10.0.10.0/24"` | no |
| <a name="input_vpc_subnet1_region"></a> [vpc\_subnet1\_region](#input\_vpc\_subnet1\_region) | n/a | `string` | `"europe-west2"` | no |
| <a name="input_vpc_subnet2_ip_cidr"></a> [vpc\_subnet2\_ip\_cidr](#input\_vpc\_subnet2\_ip\_cidr) | IP range | `string` | `"10.0.20.0/24"` | no |
| <a name="input_vpc_subnet2_region"></a> [vpc\_subnet2\_region](#input\_vpc\_subnet2\_region) | n/a | `string` | `"europe-west1"` | no |
| <a name="input_wp_playbook"></a> [wp\_playbook](#input\_wp\_playbook) | n/a | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | `"zone1"` | no |

## Outputs

No outputs.
