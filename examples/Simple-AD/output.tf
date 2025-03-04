# outputs of workspaces directory
output "id" {
  value       = module.ad.directory_id
  description = "directory name."
}
output "name" {
  value       = module.ad.directory_name
  description = "directory name."
}
