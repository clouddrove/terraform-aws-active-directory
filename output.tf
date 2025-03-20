# outputs of workspaces directory
output "directory_id" {
  value = try(
    aws_directory_service_directory.simpleAD[0].id,
    aws_directory_service_directory.microsoftAD[0].id,
    aws_directory_service_directory.ad_connector[0].id
  )
}

output "directory_name" {
  value = try(
    aws_directory_service_directory.simpleAD[0].name,
    aws_directory_service_directory.microsoftAD[0].name,
    aws_directory_service_directory.ad_connector[0].name
  )
  description = "directory name."
}
