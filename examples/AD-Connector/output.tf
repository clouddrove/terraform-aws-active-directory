# Outputs for Simple AD module

output "directory_id" {
  value       = module.ad-connector.directory_id
  description = "The ID of the Microsoft AD directory."
}

output "directory_name" {
  value       = module.ad-connector.directory_name
  description = "The name of the Microsoft AD directory."
}