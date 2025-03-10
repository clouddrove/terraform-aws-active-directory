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
