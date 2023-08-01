# outputs of workspaces directory
output "directory_id" {
  value = join("", aws_workspaces_directory.main[*].id)
}

output "directory_name" {
  value       = join("", aws_directory_service_directory.main[*].name)
  description = "directory name."
}
