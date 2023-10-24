##---------------------------------------------------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
##--------------------------------------------------------------------------------------------------------------------------
provider "aws" {
  region = local.region
}

locals {
  region      = "eu-west-1"
  name        = "ad"
  environment = "test"
}
#----------------------------------------------------------------------------------
## A VPC is a virtual network that closely resembles a traditional network that you'd operate in your own data center.
##----------------------------------------------------------------------------------
module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "2.0.0"

  name        = "${local.name}-vpc"
  environment = local.environment
  cidr_block  = "10.0.0.0/16"
}

##-----------------------------------------------------
## A subnet is a range of IP addresses in your VPC.
##-----------------------------------------------------
module "subnets" {
  source  = "clouddrove/subnet/aws"
  version = "2.0.0"

  name               = "${local.name}-subnets"
  environment        = local.environment
  availability_zones = ["eu-west-1a", "eu-west-1b"]
  vpc_id             = module.vpc.vpc_id
  type               = "public"
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
  ipv6_cidr_block    = module.vpc.ipv6_cidr_block
}

##-----------------------------------------------------------------------------
## active-directory module call.
##-----------------------------------------------------------------------------
module "ad" {
  source = "./../"

  name         = local.name
  environment  = local.environment
  subnet_ids   = module.subnets.public_subnet_id
  vpc_settings = { vpc_id : module.vpc.vpc_id, subnet_ids : join(",", module.subnets.public_subnet_id) }
  ad_name      = "clouddrovepoc.example.com"
  ad_password  = "xyzsf58f5fqar"
  ip_whitelist = ["51.79.69.69/32"]
}
