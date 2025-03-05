variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "directory_type" {
  type        = string
  default     = "MicrosoftAD"
  description = "The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values)."
}

variable "directory_name" {
  type        = string
  default     = "ld.clouddrove.ca"
  description = "The fully qualified name for the directory, such as corp.example.com."
}

variable "directory_size" {
  type        = string
  default     = "Small"
  description = "The size of the directory (Small or Large are accepted values)."
}

variable "ip_rules" {
  type = list(object({
    source      = string
    description = string
  }))
  default = [
    {
      source      = "43.224.1.228/32" // change it according to your requirement
      description = "NAT"
    },
    {
      source      = "125.191.14.85/32" // change it according to your requirement
      description = "NAT"
    },
  ]
  description = "List of IP rules."
}

variable "subnet_ids" {
  type        = list(string)
  default     = null
  description = "List of subnets in VPC."
}

variable "vpc_settings" {
  type        = map(string)
  default     = {}
  description = "(Required for SimpleAD and MicrosoftAD) VPC related information about the directory."
}

variable "ad_password" {
  type        = string
  default     = "xyzsf58f5fqar"
  description = "The password for the directory administrator or connector user."
  sensitive   = true
}

variable "ip_whitelist" {
  type        = list(string)
  default     = ["183.83.54.134/32"]
  description = "List of IPs to whitelist."
}
