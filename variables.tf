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
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "anmol@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'."
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

variable "ad_name" {
  default     = "corp.example.com"
  type        = string
  description = " The fully qualified name for the directory, such as corp.example.com"
}

variable "ad_password" {
  default     = "xyzsf58f5fqar"
  type        = string
  description = "The password for the directory administrator or connector user."
  sensitive   = true
}

variable "ad_size" {
  default     = "Small"
  type        = string
  description = "The size of the directory (Small or Large are accepted values)."
}

variable "ip_whitelist" {
  default     = ["51.79.69.69/32"]
  type        = list(string)
  description = "List of IP's to for whitelist"
}

variable "custom_policy" {
  default     = ""
  type        = string
  description = "Custom policy ARN"
}

variable "enable_internet_access" {
  default     = false
  type        = bool
  description = "Indicates whether internet access is enabled for your WorkSpaces."
}

variable "change_compute_type" {
  default     = true
  type        = bool
  description = "Whether WorkSpaces directory users can change the compute type (bundle) for their workspace."
}

variable "increase_volume_size" {
  default     = true
  type        = bool
  description = "Whether WorkSpaces directory users can increase the volume size of the drives on their workspace."
}

variable "rebuild_workspace" {
  default     = true
  type        = bool
  description = "Whether WorkSpaces directory users can rebuild the operating system of a workspace to its original state."
}

variable "restart_workspace" {
  default     = true
  type        = bool
  description = "Whether WorkSpaces directory users can restart their workspace."
}

variable "switch_running_mode" {
  default     = true
  type        = bool
  description = "Whether WorkSpaces directory users can switch the running mode of their workspace."
}

variable "device_type_android" {
  default     = "ALLOW"
  type        = string
  description = " Indicates whether users can use Android devices to access their WorkSpaces."
}

variable "device_type_linux" {
  default     = "ALLOW"
  type        = string
  description = " Indicates whether users can use Linux devices to access their WorkSpaces."
}

variable "device_type_chromeos" {
  default     = "ALLOW"
  type        = string
  description = "Indicates whether users can use Chromebooks to access their WorkSpaces."
}

variable "device_type_ios" {
  default     = "ALLOW"
  type        = string
  description = "Indicates whether users can use iOS devices to access their WorkSpaces."
}

variable "device_type_osx" {
  default     = "ALLOW"
  type        = string
  description = "Indicates whether users can use macOS clients to access their WorkSpaces."
}

variable "device_type_web" {
  default     = "ALLOW"
  type        = string
  description = "Indicates whether users can access their WorkSpaces through a web browser."
}

variable "device_type_windows" {
  default     = "ALLOW"
  type        = string
  description = "Indicates whether users can use Windows clients to access their WorkSpaces."
}

variable "device_type_zeroclient" {
  default     = "ALLOW"
  type        = string
  description = "Indicates whether users can use zero client devices to access their WorkSpaces."
}

variable "enable_maintenance_mode" {
  default     = false
  type        = bool
  description = "Indicates whether maintenance mode is enabled for your WorkSpaces."
}

variable "user_enabled_as_local_administrator" {
  default     = false
  type        = bool
  description = "Indicates whether users are local administrators of their WorkSpaces."
}

variable "type" {
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
  default     = ""
  type        = string
  description = "A textual description for the directory."
}

variable "short_name" {
  default     = "CORP"
  type        = string
  description = "The short name of the directory, such as CORP."
}

variable "edition" {
  default     = "Enterprise"
  type        = string
  description = "The MicrosoftAD edition (Standard or Enterprise)."
}

variable "subnet_ids" {
  default     = null
  type        = list(string)
  description = "List of subnets in VPC"
}
