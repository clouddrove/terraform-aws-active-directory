variable "directory_size" {
  description = "The size of the directory (Small or Large are accepted values). Small by default."
  type        = string
  default     = "Small" # Provide a default value
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


