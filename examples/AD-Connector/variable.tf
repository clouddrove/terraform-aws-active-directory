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


