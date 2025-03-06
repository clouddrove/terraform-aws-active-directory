variable "directory_type" {
  type        = string
  default     = ""
  description = "The directory type."
}

variable "directory_name" {
  type        = string
  description = "The fully qualified name for the directory, such as corp.example.com."
  default     = ""
}

variable "directory_size" {
  type        = string
  default     = "Small"
  description = "The size of the directory (Small or Large are accepted values)."
}

variable "enable_sso" {
  description = "Enable Single Sign-On"
  type        = bool
  default     = false
}

variable "edition" {
  description = "The edition of Microsoft AD"
  type        = string
  default     = "Standard"
}

variable "alias" {
  description = "Alias for the Microsoft AD"
  type        = string
  default     = "clouddrove-ad"
}

variable "ip_rules" {
  type = list(object({
    source      = string
    description = string
  }))
  default = [
    {
      source      = "43.224.1.228/32"
      description = "NAT"
    },
    {
      source      = "125.191.14.85/32"
      description = "NAT"
    },
  ]
  description = "List of IP rules."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets in VPC."
  default     = []
}

variable "vpc_settings" {
  type        = map(string)
  description = "VPC related information about the directory."
  default     = {}
}

variable "ad_password" {
  type        = string
  description = "The password for the directory administrator."
  sensitive   = true
  default     = ""
}
