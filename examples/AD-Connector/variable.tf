variable "customer_dns_ips" {
  type        = list(string)
  description = "(Required) The DNS IP addresses of the domain to connect to."
  default     = []
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Flag to control the module creation."
}
variable "customer_username" {
  type        = string
  description = "(Required) The username corresponding to the password provided."
  default     = ""
}

variable "directory_type" {
  default     = "ADConnector"
  type        = string
  description = "The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values)."
}

variable "directory_size" {
  description = "The size of the directory (Small or Large are accepted values). Small by default."
  type        = string
  default     = "Small" # Provide a default value
}

variable "ip_rules" {
  description = "List of IP rules"
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
}

variable "vpc_settings" {
  type        = map(string)
  default     = {}
  description = "(Required for SimpleAD and MicrosoftAD) VPC related information about the directory. Fields documented below."

}

variable "ad_password" {
  default     = ""
  type        = string
  description = "The password for the directory administrator or connector user."
  sensitive   = true
}

