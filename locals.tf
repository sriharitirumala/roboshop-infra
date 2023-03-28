locals{
  ## Private Subnets
  private_subnets_ids = {for k, v in module.vpc.private_subnets : k ==> v.id}
}
