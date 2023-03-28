locals {
  ## Private Subnets
  #private_subnets_ids = [for k, v in module.vpc["main"].private_subnets : v.id]
  private_subnets_ids = { for k, v in module.vpc["main"].private_subnets : k => tomap({ "id" = v.id, "availability_zone" = v.availability_zone }) }
}
