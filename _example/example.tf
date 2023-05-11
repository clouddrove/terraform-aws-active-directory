
provider "aws" {
  region = "eu-west-1"

}
module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "1.3.0"

  name        = "vpc"
  environment = "test"
  label_order = ["name", "environment"]

  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source             = "clouddrove/subnet/aws"
  version            = "1.3.0"
  name               = "subnets"
  environment        = "test"
  label_order        = ["name", "environment"]
  availability_zones = ["eu-west-1a", "eu-west-1b"]
  vpc_id             = module.vpc.vpc_id
  type               = "public"
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
  ipv6_cidr_block    = module.vpc.ipv6_cidr_block
}

module "ad" {
  source       = "./../"
  environment  = "test"
  name         = "adclouddrove"
  label_order  = ["name", "environment"]
  subnet_ids   = module.subnets.public_subnet_id
  vpc_settings = { vpc_id : module.vpc.vpc_id, subnet_ids : join(",", module.subnets.public_subnet_id) }
  ad_name      = "clouddrovepoc.example.com"
  ad_password  = "xyz123@abc"
  ip_whitelist = ["51.79.69.69/32"]
}
