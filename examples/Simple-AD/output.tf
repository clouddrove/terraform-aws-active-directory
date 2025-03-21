# Outputs for Simple AD module

output "directory_id" {
  value       = module.simple-ad.directory_id
  description = "The ID of the Simple AD directory."
}

output "directory_name" {
  value       = module.simple-ad.directory_name
  description = "The name of the Simple AD directory."
}
