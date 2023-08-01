##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##-----------------------------------------------------------------------------
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "1.3.0"

  name        = var.name
  environment = var.environment
  attributes  = var.attributes
  repository  = var.repository
  managedby   = var.managedby
  label_order = var.label_order
}

##-----------------------------------------------------------------------------
## Provides a WorkSpaces directory in AWS WorkSpaces Service. NOTE: AWS WorkSpaces service requires workspaces_DefaultRole IAM role to operate normally.
##-----------------------------------------------------------------------------
resource "aws_workspaces_directory" "main" {
  count = var.enabled ? 1 : 0

  directory_id = join("", aws_directory_service_directory.main[*].id)
  subnet_ids   = var.subnet_ids

  ip_group_ids = [
    join("", aws_workspaces_ip_group.ipgroup[*].id),
  ]

  tags = module.labels.tags

  self_service_permissions {
    change_compute_type  = var.change_compute_type
    increase_volume_size = var.increase_volume_size
    rebuild_workspace    = var.rebuild_workspace
    restart_workspace    = var.restart_workspace
    switch_running_mode  = var.switch_running_mode
  }

  workspace_access_properties {
    device_type_android    = var.device_type_android
    device_type_chromeos   = var.device_type_chromeos
    device_type_ios        = var.device_type_ios
    device_type_osx        = var.device_type_osx
    device_type_web        = var.device_type_web
    device_type_windows    = var.device_type_windows
    device_type_zeroclient = var.device_type_zeroclient
    device_type_linux      = var.device_type_linux
  }

  workspace_creation_properties {
    enable_internet_access              = var.enable_internet_access
    enable_maintenance_mode             = var.enable_maintenance_mode
    user_enabled_as_local_administrator = var.user_enabled_as_local_administrator
  }

  depends_on = [
    aws_iam_role_policy_attachment.workspaces_default_service_access,
    aws_iam_role_policy_attachment.workspaces_default_self_service_access,
    aws_iam_role_policy_attachment.workspaces_custom_s3_access
  ]
}

##-----------------------------------------------------------------------------
## Resource: aws_directory_service_directory. Provides a Simple or Managed Microsoft directory in AWS Directory Service.
##-----------------------------------------------------------------------------
resource "aws_directory_service_directory" "main" {
  count       = var.enabled ? 1 : 0
  name        = var.ad_name
  password    = var.ad_password
  size        = var.ad_size
  type        = var.type
  alias       = var.alias
  enable_sso  = var.enable_sso
  description = var.description
  short_name  = var.short_name
  edition     = var.edition
  tags        = module.labels.tags

  dynamic "vpc_settings" {
    for_each = length(keys(var.vpc_settings)) == 0 ? [] : [var.vpc_settings]

    content {
      subnet_ids = split(",", lookup(vpc_settings.value, "subnet_ids", null))
      vpc_id     = lookup(vpc_settings.value, "vpc_id", null)
    }
  }

  dynamic "connect_settings" {
    for_each = length(keys(var.connect_settings)) == 0 ? [] : [var.connect_settings]

    content {
      customer_username = lookup(connect_settings.value, "customer_username", null)
      customer_dns_ips  = lookup(connect_settings.value, "customer_dns_ips", null)
      subnet_ids        = split(",", lookup(connect_settings.value, "subnet_ids", null))
      vpc_id            = lookup(connect_settings.value, "vpc_id", null)
    }
  }

}

data "aws_iam_policy_document" "workspaces" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["workspaces.amazonaws.com"]
    }
  }
}

##-----------------------------------------------------------------------------
## aws_iam_role. An IAM role is an AWS Identity and Access Management (IAM) entity with permissions to make AWS service requests.
##-----------------------------------------------------------------------------
resource "aws_iam_role" "workspaces_default" {
  count              = var.enabled ? 1 : 0
  name               = format("%s-workspaces_Role", module.labels.id)
  assume_role_policy = data.aws_iam_policy_document.workspaces.json
}

##-----------------------------------------------------------------------------
## aws_iam_role_policy_attachment Attaches a Managed IAM Policy to an IAM role.
##-----------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "workspaces_default_service_access" {
  count      = var.enabled ? 1 : 0
  role       = join("", aws_iam_role.workspaces_default[*].name)
  policy_arn = "arn:aws:iam::aws:policy/AmazonWorkSpacesServiceAccess"
}

resource "aws_iam_role_policy_attachment" "workspaces_default_self_service_access" {
  count      = var.enabled ? 1 : 0
  role       = join("", aws_iam_role.workspaces_default[*].name)
  policy_arn = "arn:aws:iam::aws:policy/AmazonWorkSpacesSelfServiceAccess"
}

resource "aws_iam_role_policy_attachment" "workspaces_custom_s3_access" {
  count      = var.enabled && var.custom_policy != "" ? 1 : 0
  role       = join("", aws_iam_role.workspaces_default[*].name)
  policy_arn = var.custom_policy
}

#Module      : aws_workspaces_ip_group
#Description : Provides an IP access control group in AWS WorkSpaces Service
locals {
  ip_rules = var.ip_whitelist
}

##-----------------------------------------------------------------------------
## aws_workspaces_ip_group provides an IP access control group in AWS WorkSpaces Service.
##-----------------------------------------------------------------------------
resource "aws_workspaces_ip_group" "ipgroup" {
  count = var.enabled ? 1 : 0
  name  = format("%s-ipgroup", var.name)
  dynamic "rules" {
    for_each = local.ip_rules
    content {
      source = rules.value
    }
  }
}
