module "vpc" {
  source = "git::https://githun.com/sriharitirumala/tf-module-vpc.git"
  env = var.env

  for_each = var.vpc
  vpc_cidr = each.value["cidr"]
}
