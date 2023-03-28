locals {
  ## Private Subnets
  private_subnets_ids = [for k, v in module.vpc["main"].private_subnets : v.id]
}
