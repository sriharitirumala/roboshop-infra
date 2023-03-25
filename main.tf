module "vpc" {
  source = "git::https://github.com/sriharitirumala/tf-module-vpc.git"
  env = var.env
  tags = var.tags
  default_route_tags = var.default_route_table
  default_vpc_id = var.default_vpc_id

  for_each = var.vpc
  vpc_cidr = each.value ["vpc_cidr"]
  public_subnets = each.value ["public_subnets"]
  private_subnets = each.value ["private_subnets"]
}



output "vpc" {
  value = module.vpc
}
