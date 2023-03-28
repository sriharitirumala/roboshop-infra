locals {
  ## Private Subnets
  private_subnet_ids = [for k, v in module.vpc["main"].private_subnets : v.id]
}
