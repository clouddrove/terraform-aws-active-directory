##-----------------------------------------------------------------------------
## Labels module called that will be used for naming and tags.
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
## Provides a WorkSpaces directory in AWS WorkSpaces Service.
## NOTE: AWS WorkSpaces service requires workspaces_DefaultRole IAM role to operate normally.
##-----------------------------------------------------------------------------
resource "aws_workspaces_directory" "main" {
  count = var.enabled ? 1 : 0

  directory_id = join("", flatten([
    try(aws_directory_service_directory.simpleAD[*].id, []),
    try(aws_directory_service_directory.microsoftAD[*].id, []),
    try(aws_directory_service_directory.ad_connector[*].id, [])
  ]))

  subnet_ids = var.subnet_ids
  ip_group_ids = [
    join("", aws_workspaces_ip_group.ipgroup[*].id),
  ]

  tags = module.labels.tags

  self_service_permissions {
    change_compute_type  = var.self_service_permissions.change_compute_type
    increase_volume_size = var.self_service_permissions.increase_volume_size
    rebuild_workspace    = var.self_service_permissions.rebuild_workspace
    restart_workspace    = var.self_service_permissions.restart_workspace
    switch_running_mode  = var.self_service_permissions.switch_running_mode
  }

  workspace_access_properties {
    device_type_android    = var.workspace_access_properties.device_type_android
    device_type_chromeos   = var.workspace_access_properties.device_type_chromeos
    device_type_ios        = var.workspace_access_properties.device_type_ios
    device_type_osx        = var.workspace_access_properties.device_type_osx
    device_type_web        = var.workspace_access_properties.device_type_web
    device_type_windows    = var.workspace_access_properties.device_type_windows
    device_type_zeroclient = var.workspace_access_properties.device_type_zeroclient
    device_type_linux      = var.workspace_access_properties.device_type_linux
  }

  workspace_creation_properties {
    enable_internet_access              = var.workspace_creation_properties.enable_internet_access
    enable_maintenance_mode             = var.workspace_creation_properties.enable_maintenance_mode
    user_enabled_as_local_administrator = var.workspace_creation_properties.user_enabled_as_local_administrator
    custom_security_group_id            = var.workspace_creation_properties.custom_security_group_id
    default_ou                          = var.workspace_creation_properties.default_ou
  }

  depends_on = [
    aws_iam_role_policy_attachment.workspaces_default_service_access,
    aws_iam_role_policy_attachment.workspaces_default_self_service_access,
    aws_iam_role_policy_attachment.workspaces_custom_s3_access
  ]
}

##-----------------------------------------------------------------------------
## Simple Active Directory Resources
##-----------------------------------------------------------------------------

resource "random_password" "simple_ad_password" {
  count            = var.directory_type == "SimpleAD" && (var.ad_password == null || var.ad_password == "") ? 1 : 0
  length           = 20
  special          = true
  override_special = "!@#$%^&*()"
}

resource "aws_ssm_parameter" "simple_ad_password" {
  count = var.directory_type == "SimpleAD" && var.create_ssm_parameter ? 1 : 0
  name  = coalesce(var.ssm_parameter_name, "/workspace/simple-ad/password")
  type  = "SecureString"
  value = random_password.simple_ad_password[0].result # Use index since count is set

  lifecycle {
    ignore_changes = [value] # Prevents unnecessary updates
  }
}

resource "aws_directory_service_directory" "simpleAD" {
  count       = var.directory_type == "SimpleAD" ? 1 : 0
  name        = var.directory_name
  password    = coalesce(var.ad_password, try(random_password.simple_ad_password[0].result, ""))
  size        = var.directory_size
  type        = var.directory_type
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
}

##-----------------------------------------------------------------------------
## Microsoft AD Resources
# ##-----------------------------------------------------------------------------
resource "random_password" "microsoft_ad_password" {
  count            = var.directory_type == "MicrosoftAD" && (var.ad_password == null || var.ad_password == "") ? 1 : 0
  length           = 20
  special          = true
  override_special = "!@#$%^&*()"
}
resource "aws_ssm_parameter" "microsoft_ad_password" {
  count = var.directory_type == "MicrosoftAD" && var.create_ssm_parameter ? 1 : 0
  name  = coalesce(var.ssm_parameter_name, "/workspace/microsoft-ad/password")
  type  = "SecureString"
  value = random_password.microsoft_ad_password[0].result # Use index since count is set

  lifecycle {
    ignore_changes = [value] # Prevents unnecessary updates
  }
}

resource "aws_directory_service_directory" "microsoftAD" {
  count       = var.directory_type == "MicrosoftAD" ? 1 : 0
  name        = var.directory_name
  password    = coalesce(var.ad_password, try(random_password.microsoft_ad_password[0].result, ""))
  size        = var.directory_size
  type        = var.directory_type
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
}

##-----------------------------------------------------------------------------
## AD Connector Resources
##-----------------------------------------------------------------------------
resource "random_password" "ad_connector_password" {
  count            = var.directory_type == "ADConnector" && (var.ad_password == null || var.ad_password == "") ? 1 : 0
  length           = 20
  special          = true
  override_special = "!@#$%^&*()"
}

resource "aws_ssm_parameter" "ad_connector_password" {
  count = var.directory_type == "ADConnector" && var.create_ssm_parameter ? 1 : 0
  name  = coalesce(var.ssm_ad_connector_parameter_name, "/workspace/adConnector/password")
  type  = "SecureString"
  value = random_password.ad_connector_password[0].result

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_directory_service_directory" "ad_connector" {
  count       = var.directory_type == "ADConnector" ? 1 : 0
  name        = var.directory_name
  password    = coalesce(var.ad_password, try(random_password.ad_connector_password[0].result, ""))
  size        = var.directory_size
  type        = var.directory_type
  alias       = var.alias
  enable_sso  = var.enable_sso
  description = var.description
  short_name  = var.short_name
  edition     = var.edition
  tags        = module.labels.tags

  connect_settings {
    customer_dns_ips  = var.customer_dns_ips
    customer_username = var.customer_username
    subnet_ids        = var.subnet_ids
    vpc_id            = var.vpc_id
  }
}

##-----------------------------------------------------------------------------
## IAM Role and Policy Attachments
##-----------------------------------------------------------------------------
data "aws_iam_policy_document" "workspaces" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["workspaces.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "workspaces_default" {
  count              = var.enabled ? 1 : 0
  name               = format("%s-workspaces-role", module.labels.id)
  assume_role_policy = var.custom_assume_role_policy != null ? var.custom_assume_role_policy : data.aws_iam_policy_document.workspaces.json
}

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

##-----------------------------------------------------------------------------
## IP Access Control Group
##-----------------------------------------------------------------------------
resource "aws_workspaces_ip_group" "ipgroup" {
  name        = format("%s-ipgroup", var.name)
  description = var.ip_group_description

  dynamic "rules" {
    for_each = var.ip_rules
    content {
      source      = rules.value.source
      description = rules.value.description
    }
  }
}
