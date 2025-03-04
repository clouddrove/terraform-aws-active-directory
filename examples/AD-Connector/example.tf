
##---------------------------------------------------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
##--------------------------------------------------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

#----------------------------------------------------------------------------------
## A VPC is a virtual network that closely resembles a traditional network that you'd operate in your own data center.
##----------------------------------------------------------------------------------
module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "2.0.0"

  name        = "vpc"
  environment = "test-01"
  label_order = ["name", "environment"]

  cidr_block = "10.10.0.0/16"
}

##-----------------------------------------------------
## A subnet is a range of IP addresses in your VPC.
##-----------------------------------------------------
module "subnets" {
  source             = "clouddrove/subnet/aws"
  version            = "2.0.1"
  name               = "subnets"
  environment        = "test-01"
  label_order        = ["name", "environment"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  vpc_id             = module.vpc.vpc_id
  type               = "public"
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
  ipv6_cidr_block    = module.vpc.ipv6_cidr_block
}

##-----------------------------------------------------------------------------
## active-directory module call.
##-----------------------------------------------------------------------------
module "ad-connector" {
  source         = "../../"
  environment    = "test-01"
  name           = "ad-clouddrove"
  label_order    = ["name", "environment"]
  directory_name = "test.ld.clouddrove.ca"
  directory_size = var.directory_size
  directory_type = var.directory_type
  subnet_ids     = module.subnets.public_subnet_id
  vpc_settings   = { vpc_id : module.vpc.vpc_id, subnet_ids : join(",", module.subnets.public_subnet_id) }
  ad_password    = "xyz123@abc"
  ip_rules       = var.ip_rules
}

