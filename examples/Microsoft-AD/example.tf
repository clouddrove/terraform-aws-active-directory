##---------------------------------------------------------------------------------------------------------------------------
## Provider Configuration
## Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
##---------------------------------------------------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

##----------------------------------------------------------------------------------
## Virtual Private Cloud (VPC)
## A VPC is a virtual network that closely resembles a traditional network that you'd operate in your own data center.
##----------------------------------------------------------------------------------
module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "2.0.0"

  name        = "vpc"
  environment = "test"
  label_order = ["name", "environment"]

  cidr_block = "10.0.0.0/16"
}

##-----------------------------------------------------
## Subnets
## A subnet is a range of IP addresses in your VPC.
##-----------------------------------------------------
module "subnets" {
  source             = "clouddrove/subnet/aws"
  version            = "2.0.1"
  name               = "subnets"
  environment        = "test"
  label_order        = ["name", "environment"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  vpc_id             = module.vpc.vpc_id
  type               = "public"
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
  ipv6_cidr_block    = module.vpc.ipv6_cidr_block
}

##-----------------------------------------------------------------------------
## Microsoft Active Directory
## This module sets up a Microsoft Active Directory within the specified VPC.
##-----------------------------------------------------------------------------
module "microsoft-ad" {
  source         = "../../"
  environment    = "test"
  name           = "ad-clouddrove"
  label_order    = ["name", "environment"]
  directory_type = "MicrosoftAD"
  directory_size = "Small"
  directory_name = "test.ld.clouddrove.ca"
  subnet_ids     = module.subnets.public_subnet_id
  vpc_settings   = { vpc_id : module.vpc.vpc_id, subnet_ids : join(",", module.subnets.public_subnet_id) }
  ad_password    = "xyz123@abc"
  ip_rules       = var.ip_rules

  # Additional features
  # Additional optional parameters for more features
  edition     = "Standard" # Can be "Standard" or "Enterprise"
  short_name  = "clouddrove"
  description = "Microsoft AD for Clouddrove"
  enable_sso  = false
  alias       = "clouddrove-ad"
}
