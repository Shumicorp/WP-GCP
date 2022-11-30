
module "vpc_network" {
  # VPC with 2 subnetworks, router, nat
  source          = "./modules/vpc-network"
  name            = var.app_name
  sufix           = var.app-name-sufix
  subnet1-ip_cidr = var.vpc-subnet1-ip_cidr
  subnet1-region  = var.vpc-subnet1-region
  subnet2-ip_cidr = var.vpc-subnet2-ip_cidr
  subnet2-region  = var.vpc-subnet2-region
}
module "bastion" {
  source         = "./modules/bastion"
  name           = var.app_name
  app-name-sufix = var.app-name-sufix
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
module "service-account" {
  source     = "./modules/service-account"
  project    = var.project
  account_id = var.account_id
  roles      = var.roles
}
module "storage" {
  source               = "./modules/storage"
  bucket_name          = var.app_name
  bucket-name-sufix    = var.app-name-sufix
  bucket-location      = var.bucket-location
  bucket-lifecycle-age = var.bucket-lifecycle-age
  bucket-versioning    = var.bucket-versioning
  sa                   = module.service-account.email
  bucket-sa-role       = var.bucket-sa-role
  depends_on           = [module.service-account]
}

#data "google_secret_manager_secret_version" "dbpass" {
#  secret = "dbpass"
#}
module "secret-manager" {
  source    = "./modules/secrets"
  length    = var.secret_lenght
  secret_id = var.secret_id
  labels    = var.secret_labels
}

module "db-mysql" {
  source              = "./modules/cloud-sql"
  vpc-net             = module.vpc_network.vpc
  db-service-name     = var.app_name
  app-name-sufix      = var.app-name-sufix
  region              = var.db-region
  database_version    = var.database_version
  deletion_protection = var.deletion_protection
  db-instance-type    = var.db-instance-type
  zone1               = var.db-zone1
  zone2               = var.db-zone2
  db-user-name        = var.db-user-name
  db-database-name    = var.db-database-name
  #db-user-pass        = data.google_secret_manager_secret_version.dbpass.secret_data
  db-user-pass = module.secret-manager.secret
  depends_on   = [module.vpc_network]
}

module "packer" {
  source               = "./modules/packer/"
  subnet               = module.vpc_network.private_subnet.id
  project              = var.project
  zone                 = var.zone
  app-name-sufix       = var.app-name-sufix
  app-name             = var.app_name
  source-image         = var.source_image_packer
  bastion-ip           = module.bastion.ip
  ssh-private-key-path = var.ssh-private-key-path
  ssh-username         = var.ssh-username-packer
  packer-machine-type  = var.packer-machine-type
  playbook             = var.wp-playbook
  ansible-extra-vars   = "bucket=${module.storage.bucket} db_name=${var.db-database-name} db_ip=${module.db-mysql.db-ip} password=${module.secret-manager.secret} user=${var.db-user-name}"
  depends_on           = [module.vpc_network, module.storage.bucket, module.secret-manager, module.db-mysql.db_ip]
}

module "mig" {
  source                    = "./modules/mig"
  app_name                  = var.app_name
  app-name-sufix            = var.app-name-sufix
  tags                      = var.mig_tags
  mig_machine_type          = var.mig_machine_type
  vpc                       = module.vpc_network.vpc.id
  sub-net                   = module.vpc_network.private_subnet.id
  sa                        = module.service-account.email
  startup_script            = templatefile("./templatefile/wp-mig.tftpl", { bucket = "${module.storage.bucket}" })
  mig-region                = var.region
  distribution_policy_zones = var.mig_distribution_policy_zones
  mig_port_name             = var.mig_port_name
  mig_port                  = var.mig_port
  auto_healing_delay        = var.auto_healing_delay
  autoscaler-max            = var.autoscaler-max
  autoscaler-min            = var.autoscaler-min
  depends_on                = [module.packer, module.vpc_network, module.service-account]
}

module "load-balancer" {
  source   = "./modules/load-balancer"
  app_name = var.app_name
  mig-id   = module.mig.mig-id
  check    = [module.mig.health-check]
  ssl-domains = ["mrusn-wp.pp.ua."]
  depends_on = [module.mig]
}
