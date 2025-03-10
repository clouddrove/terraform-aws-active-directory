##---------------------------------------------------------------------------------------------------------------------------
## Provider Configuration
## Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
##---------------------------------------------------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

##----------------------------------------------------------------------------------
## VPC Module
## A VPC (Virtual Private Cloud) is a virtual network that closely resembles a traditional network that you'd operate in your own data center.
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
## Subnets Module
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
## Active Directory Connector Module
## This module sets up a Active Directory Connector within the specified VPC and subnets.
##-----------------------------------------------------------------------------
module "ad-connector" {
  source            = "../../"
  environment       = "test"
  name              = "ad-clouddrove"
  label_order       = ["name", "environment"]
  directory_name    = "ld.clouddrove.ca"
  directory_type    = "ADConnector"
  directory_size    = "Small"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.subnets.public_subnet_id
  ad_password       = "xyz123@abc"
  ip_rules          = var.ip_rules
  customer_dns_ips  = ["43.224.1.220"]
  customer_username = "clouddrove-user"

  # Additional features
  # Additional optional parameters for more features
  edition     = "Standard" # Can be "Standard" or "Enterprise"
  short_name  = "clouddrove"
  description = "AD Connector for Clouddrove"
  enable_sso  = false
  alias       = ""
}
