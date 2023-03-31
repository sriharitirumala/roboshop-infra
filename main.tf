module "vpc" {
  source                = "git::https://github.com/sriharitirumala/tf-module-vpc.git"
  env                   = var.env
  tags                  = var.tags
  default_route_table   = var.default_route_table
  default_vpc_id        = var.default_vpc_id

  for_each              = var.vpc
  vpc_cidr              = each.value ["vpc_cidr"]
  public_subnets        = each.value ["public_subnets"]
  private_subnets       = each.value ["private_subnets"]
}



module "docdb" {
  source                          = "git::https://github.com/sriharitirumala/tf-module-docdb.git"
  env                             = var.env
  tags                            = var.tags

  subnet_ids                      = local.subnet_ids ["db"]
  for_each                        = var.docdb
  engine                          = each.value ["engine"]
  engine_version                  = each.value ["engine_version"]
  backup_retention_period         = each.value ["backup_retention_period"]
  preferred_backup_window         = each.value ["preferred_backup_window"]
  skip_final_snapshot             = each.value ["skip_final_snapshot"]
  no_of_instances                 = each.value["no_of_instances"]
  instance_class                  = each.value["instance_class"]
}

module "rds" {
  source                          = "git::https://github.com/sriharitirumala/tf-module-rds.git"
  env                             = var.env
  tags                            = var.tags

  subnet_ids                      = local.subnet_ids ["db"]
  for_each                        = var.rds
  engine                          = each.value ["engine"]
  engine_version                  = each.value ["engine_version"]
  backup_retention_period         = each.value ["backup_retention_period"]
  preferred_backup_window         = each.value ["preferred_backup_window"]
  instance_class                  = each.value ["instance_class"]
  no_of_instances                 = each.value ["no_of_instances"]
}


module "elasticache" {
  source                          = "git::https://github.com/sriharitirumala/tf-module-elasticache.git"
  env                             = var.env
  tags                            = var.tags

  subnet_ids                      = local.subnet_ids ["db"]
  for_each                        = var.elasticache
  engine                          = each.value ["engine"]
  engine_version                  = each.value ["engine_version"]
  node_type                       = each.value ["node_type"]
  num_cache_nodes                 = each.value ["num_cache_nodes"]
}

module "rabbitmq" {
  source                          = "git::https://github.com/sriharitirumala/tf-module-rabbitmq.git"
  env                             = var.env
  tags                            = var.tags

  subnet_ids                      = local.subnet_ids ["db"]
  for_each                        = var.rabbitmq
  instance_type                   = each.value ["instance_type"]


}


module "alb" {
  source = "git::https://github.com/sriharitirumala/tf-module-alb.git"
  env    = var.env
  tags   = var.tags

  vpc_id             = module.vpc["main"].vpc_id

  for_each           = var.alb
  name               = each.value["name"]
  internal           = each.value["internal"]
  load_balancer_type = each.value["load_balancer_type"]
  subnets            = lookup(local.subnet_ids, each.value["subnet_name"], null)
  allow_cidr         = each.value["allow_cidr"]
}



module "app" {
  source = "git::https://github.com/sriharitirumala/tf-module-app.git"
  env    = var.env
  tags   = var.tags
  bastion_cidr = var.bastion_cidr
  dns_domain   = var.dns_domain

  vpc_id             = module.vpc["main"].vpc_id

  for_each           = var.app
  component          = each.value["component"]
  instance_type      = each.value["instance_type"]
  desired_capacity   = each.value["desired_capacity"]
  max_size           = each.value["max_size"]
  min_size           = each.value["min_size"]
  subnets            = lookup(local.subnet_ids, each.value["subnet_name"], null)
  port               = each.value["port"]
  allow_app_to       = lookup(local.subnet_cidr, each.value["allow_app_to"], null)
  alb_dbs_name       = lookup(lookup(lookup(module.alb, each.value["alb"], null ),"alb",null), "dns_name", null)
}


output "alb" {
  value = module.alb
}







