# Outputs for Simple AD module

output "directory_id" {
  value       = module.microsoft-ad.directory_id
  description = "The ID of the Microsoft AD directory."
}

output "directory_name" {
  value       = module.microsoft-ad.directory_name
  description = "The name of the Microsoft AD directory."
}