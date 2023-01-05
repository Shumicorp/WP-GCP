module "vpc_network" {
  source          = "./modules/vpc-network"
  name            = var.app_name
  prefix          = var.app_name_prefix
  subnet1_ip_cidr = var.vpc_subnet1_ip_cidr
  subnet1_region  = var.vpc_subnet1_region
  subnet2_ip_cidr = var.vpc_subnet2_ip_cidr
  subnet2_region  = var.vpc_subnet2_region
}
module "bastion" {
  source         = "./modules/bastion"
  name           = var.app_name 
  prefix         = var.app_name_prefix
  network        = module.vpc_network.vpc
  subnet         = module.vpc_network.private_subnet
  zone           = var.zone
  depends_on     = [module.vpc_network]
}
module "firewall" {
  source     = "./modules/firewall"
  network    = module.vpc_network.vpc
  firewall   = var.firewall
  depends_on = [module.vpc_network]
}

module "service_account" {
  source     = "./modules/service-account"
  project    = var.project
  account_id = var.account_id
  roles      = var.roles
}

module "storage" {
  source               = "./modules/storage"
  bucket_name          = var.app_name  #will be app_name-prefix-bucket
  prefix               = var.app_name_prefix
  bucket_location      = var.bucket_location
  bucket_lifecycle_age = var.bucket_lifecycle_age
  bucket_versioning    = var.bucket_versioning
  sa                   = module.service_account.email
  bucket_sa_role       = var.bucket_sa_role
  depends_on           = [module.service_account]
}

#data "google_secret_manager_secret_version" "dbpass" {
#  secret = "dbpass"
#}
module "secret_manager" {
  source    = "./modules/secrets"
  length    = var.secret_lenght
  secret_id = var.secret_id
  labels    = var.secret_labels
}

module "db_mysql" {
  source              = "./modules/cloud-sql"
  vpc_net             = module.vpc_network.vpc
  db_service_name     = var.app_name
  prefix              = var.app_name_prefix
  region              = var.db_region
  database_version    = var.database_version
  deletion_protection = var.deletion_protection
  db_instance_type    = var.db_instance_type
  zone1               = var.db_zone1
  zone2               = var.db_zone2
  db_user_name        = var.db_user_name
  db_database_name    = var.db_database_name
  #db_user_pass        = data.google_secret_manager_secret_version.dbpass.secret_data
  db_user_pass = module.secret_manager.secret
  depends_on   = [module.vpc_network]
}

module "packer" {
  source               = "./modules/packer/"
  subnet               = module.vpc_network.private_subnet.id
  project              = var.project
  zone                 = var.zone
  prefix               = var.app_name_prefix
  app_name             = var.app_name
  source_image         = var.source_image_packer
  bastion_ip           = module.bastion.ip
  ssh_private_key_path = var.ssh_private_key_path
  ssh_username         = var.ssh_username_packer
  packer_machine_type  = var.packer_machine_type
  playbook             = var.wp_playbook
  ansible_extra_vars   = "bucket=${module.storage.bucket} db_name=${var.db_database_name} db_ip=${module.db_mysql.db-ip} password=${module.secret_manager.secret} user=${var.db_user_name} dns_name=${var.dns_name}"
  depends_on           = [module.vpc_network, module.storage.bucket, module.secret_manager, module.db_mysql.db_ip]
}  

module "mig" {
  source                    = "./modules/mig"
  app_name                  = var.app_name
  prefix                    = var.app_name_prefix
  tags                      = var.mig_tags
  mig_machine_type          = var.mig_machine_type
  vpc                       = module.vpc_network.vpc.id
  sub_net                   = module.vpc_network.private_subnet.id
  sa                        = module.service_account.email
  startup_script            = templatefile("./templatefile/wp-mig.tftpl", { bucket = "${module.storage.bucket}" })
  mig_region                = var.region
  distribution_policy_zones = var.mig_distribution_policy_zones
  mig_port_name             = var.mig_port_name
  mig_port                  = var.mig_port
  auto_healing_delay        = var.auto_healing_delay
  autoscaler_max            = var.autoscaler_max
  autoscaler_min            = var.autoscaler_min
  depends_on                = [module.packer, module.vpc_network, module.service_account]
}

module "load-balancer" {
  source     = "./modules/load-balancer"
  app_name   = var.app_name
  mig_id     = module.mig.mig_id
  check      = [module.mig.health_check]
  ssl_id     = [module.static.ssl_id]
  front_ip   = module.static.front_ip
  depends_on = [module.mig.mig_id, module.static]
}

module "static" {
  source      = "./modules/static"
  app_name    = var.app_name
  ssl_domains = ["${var.domain}."]
}

module "dns" {
  source     = "./modules/cloud-dns"
  ip         = [module.static.front_ip]
  new_zone   = var.new_zone
  dns_name   = var.dns_name
  domain     = var.domain 
  dns_type   = var.dns_type
  depends_on = [module.static.front_ip]
}
