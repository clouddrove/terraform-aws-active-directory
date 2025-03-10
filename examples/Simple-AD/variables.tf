variable "directory_type" {
  default     = "SimpleAD"
  type        = string
  description = "The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values)."
}

variable "edition" {
  default     = "Standard"
  type        = string
  description = "The MicrosoftAD edition (Standard or Enterprise)."
}

variable "alias" {
  description = "Alias for AWS Directory Service"
  type        = string
  default     = ""
}

variable "short_name" {
  default     = "CORP"
  type        = string
  description = "The short name of the directory, such as CORP."
}

variable "description" {
  default     = "Default Active Directory"
  type        = string
  description = "A textual description for the directory."
}

variable "ip_rules" {
  type = list(object({
    source      = string
    description = string
  }))
  default = [
    {
      source      = "51.79.69.69/32" // change it according to your requirement
      description = "IP Whitelisting"
    }
  ]
  description = "List of IP rules."
}

variable "ad_password" {
  default     = ""
  type        = string
  description = "The password for the directory administrator or connector user."
  sensitive   = true
}
