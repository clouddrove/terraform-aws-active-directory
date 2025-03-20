#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "anmol@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'."
}

variable "customer_dns_ips" {
  type        = list(string)
  description = "(Required) The DNS IP addresses of the domain to connect to."
  default     = []
}

variable "customer_username" {
  type        = string
  description = "(Required) The username corresponding to the password provided."
  default     = ""
}

variable "vpc_id" {
  description = "default vpc"
  type        = string
  default     = ""
}

variable "ssm_ad_connector_parameter_name" {
  description = "ssm parameter name for microsoft AD"
  type        = string
  default     = "/workspace/Connector/password"
}

variable "create_ssm_parameter" {
  description = "If true, deploy the SSM parameter Active Directory."
  type        = bool
  default     = false
}

variable "ssm_parameter_name" {
  description = "ssm parameter name for microsoft AD"
  type        = string
  default     = "/workspace/microsoft-ad/password"
}


variable "attributes" {
  type        = list(any)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-active-directory"
  description = "Terraform current module repo"
}

#Description : Active Directory Terraform modules variables
variable "enabled" {
  type        = bool
  default     = true
  description = "Flag to control the module creation."
}

variable "vpc_settings" {
  type        = map(string)
  default     = {}
  description = "(Required for SimpleAD and MicrosoftAD) VPC related information about the directory. Fields documented below."

}

variable "connect_settings" {
  type        = map(string)
  default     = {}
  description = "(Required for ADConnector) Connector related information about the directory. Fields documented below."

}

variable "directory_name" {
  default     = "corp.example.com"
  type        = string
  description = " The fully qualified name for the directory, such as corp.example.com"
}

variable "directory_size" {
  description = "The size of the directory (Small or Large are accepted values). Large by default."
  type        = string
  default     = "Small" # Provide a default value
}

variable "ad_password" {
  default     = ""
  type        = string
  description = "The password for the directory administrator or connector user."
  sensitive   = true
}

variable "ip_rules" {
  description = "List of IP rules"
  type = list(object({
    source      = string
    description = string
  }))
  default = []
}

variable "ip_group_description" {
  type        = string
  default     = "IP Access Control Group for environment."
  description = "IP access control group description."
}

variable "custom_policy" {
  default     = ""
  type        = string
  description = "Custom policy ARN"
}

#############################################

variable "self_service_permissions" {
  description = "Self-service permissions configuration."
  type = object({
    change_compute_type  = bool
    increase_volume_size = bool
    rebuild_workspace    = bool
    restart_workspace    = bool
    switch_running_mode  = bool
  })
  default = {
    change_compute_type  = true //"Whether WorkSpaces directory users can change the compute type (bundle) for their workspace."
    increase_volume_size = true //"Whether WorkSpaces directory users can increase the volume size of the drives on their workspace."
    rebuild_workspace    = true //"Whether WorkSpaces directory users can rebuild the operating system of a workspace to its original state.""
    restart_workspace    = true //"Whether WorkSpaces directory users can restart their workspace."
    switch_running_mode  = true //"Whether WorkSpaces directory users can switch the running mode of their workspace."
  }
}
variable "workspace_access_properties" {
  description = "Workspace access properties configuration."
  type = object({
    device_type_android    = string
    device_type_chromeos   = string
    device_type_ios        = string
    device_type_linux      = string
    device_type_osx        = string
    device_type_web        = string
    device_type_windows    = string
    device_type_zeroclient = string
  })
  default = {
    device_type_android    = "ALLOW" //"Indicates whether users can use Android devices to access their WorkSpaces."
    device_type_chromeos   = "ALLOW" //"Indicates whether users can use Chromebooks to access their WorkSpaces."
    device_type_ios        = "ALLOW" //"Indicates whether users can use iOS devices to access their WorkSpaces."
    device_type_linux      = "ALLOW" //"Indicates whether users can use Linux devices to access their WorkSpaces."
    device_type_osx        = "ALLOW" //"Indicates whether users can use macOS clients to access their WorkSpaces."
    device_type_web        = "ALLOW" //"Indicates whether users can access their WorkSpaces through a web browser."
    device_type_windows    = "ALLOW" //"Indicates whether users can use Windows clients to access their WorkSpaces."
    device_type_zeroclient = "ALLOW" //"Indicates whether users can use zero client devices to access their WorkSpaces."
  }
}

variable "workspace_creation_properties" {
  description = "Workspace creation properties configuration."
  type = object({
    custom_security_group_id            = string
    default_ou                          = string
    enable_internet_access              = bool
    enable_maintenance_mode             = bool
    user_enabled_as_local_administrator = bool
  })
  default = {
    custom_security_group_id            = ""    //"The identifier of any custom security groups that are applied to the WorkSpaces directory."
    default_ou                          = ""    //"The organizational unit (OU) in the directory for the WorkSpace machine accounts."
    enable_internet_access              = true  //"Indicates whether internet access is enabled for your WorkSpaces."
    enable_maintenance_mode             = false //"Indicates whether maintenance mode is enabled for your WorkSpaces."
    user_enabled_as_local_administrator = true  //"Indicates whether users are local administrators of their WorkSpaces."
  }
}

variable "directory_type" {
  default     = "SimpleAD"
  type        = string
  description = "The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values)."
}

variable "enable_sso" {
  default     = false
  type        = bool
  description = "Whether to enable single-sign on for the directory. Requires alias."
}

variable "alias" {
  default     = ""
  type        = string
  description = "The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values)."
}


variable "description" {
  default     = "Default Active Directory"
  type        = string
  description = "A textual description for the directory."
}

variable "short_name" {
  default     = "CORP"
  type        = string
  description = "The short name of the directory, such as CORP."
}

variable "edition" {
  default     = "Standard"
  type        = string
  description = "The MicrosoftAD edition (Standard or Enterprise)."
}

variable "subnet_ids" {
  default     = null
  type        = list(string)
  description = "List of subnets in VPC"
}

variable "custom_assume_role_policy" {
  description = "Optional custom assume role policy for WorkSpaces role"
  type        = string
  default     = null
}
