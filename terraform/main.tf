locals {
  resource_prefix = "${lower(var.env)}"
}
/*
module "red_shift_cluster" {
  source                     = "./modules/red_shift_cluster"
  settings                   = var.red_shift
  iam_roles                  = module.red_shift_iam_role.redshift_role
  resource_prefix            = local.resource_prefix
}

module "red_shift_iam_role" {
  source          = "./modules/red_shift_iam_role"
  resource_prefix = local.resource_prefix
}

*/
module "Redis" {
  source = "./modules/redis"
  settings         = var.redis
  resource_prefix = local.resource_prefix
  
}
