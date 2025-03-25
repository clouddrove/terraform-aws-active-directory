## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ad\_password | The password for the directory administrator or connector user. | `string` | `""` | no |
| alias | The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values). | `string` | `""` | no |
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| create\_ssm\_parameter | If true, deploy the SSM parameter Active Directory. | `bool` | `false` | no |
| custom\_assume\_role\_policy | Optional custom assume role policy for WorkSpaces role | `string` | `null` | no |
| custom\_policy | Custom policy ARN | `string` | `""` | no |
| customer\_dns\_ips | (Required) The DNS IP addresses of the domain to connect to. | `list(string)` | `[]` | no |
| customer\_username | (Required) The username corresponding to the password provided. | `string` | `""` | no |
| description | A textual description for the directory. | `string` | `"Default Active Directory"` | no |
| directory\_name | The fully qualified name for the directory, such as corp.example.com | `string` | `"corp.example.com"` | no |
| directory\_size | The size of the directory (Small or Large are accepted values). Large by default. | `string` | `"Small"` | no |
| directory\_type | The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values). | `string` | `"SimpleAD"` | no |
| edition | The MicrosoftAD edition (Standard or Enterprise). | `string` | `"Standard"` | no |
| enable\_sso | Whether to enable single-sign on for the directory. Requires alias. | `bool` | `false` | no |
| enabled | Flag to control the module creation. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| ip\_group\_description | IP access control group description. | `string` | `"IP Access Control Group for environment."` | no |
| ip\_rules | List of IP rules | <pre>list(object({<br>    source      = string<br>    description = string<br>  }))</pre> | `[]` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| managedby | ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'. | `string` | `"anmol@clouddrove.com"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-active-directory"` | no |
| self\_service\_permissions | Self-service permissions configuration. | <pre>object({<br>    change_compute_type  = bool<br>    increase_volume_size = bool<br>    rebuild_workspace    = bool<br>    restart_workspace    = bool<br>    switch_running_mode  = bool<br>  })</pre> | <pre>{<br>  "change_compute_type": true,<br>  "increase_volume_size": true,<br>  "rebuild_workspace": true,<br>  "restart_workspace": true,<br>  "switch_running_mode": true<br>}</pre> | no |
| short\_name | The short name of the directory, such as CORP. | `string` | `"CORP"` | no |
| ssm\_ad\_connector\_parameter\_name | ssm parameter name for microsoft AD | `string` | `"/workspace/Connector/password"` | no |
| ssm\_parameter\_name | ssm parameter name for microsoft AD | `string` | `"/workspace/microsoft-ad/password"` | no |
| subnet\_ids | List of subnets in VPC | `list(string)` | `null` | no |
| vpc\_id | default vpc | `string` | `""` | no |
| vpc\_settings | (Required for SimpleAD and MicrosoftAD) VPC related information about the directory. Fields documented below. | `map(string)` | `{}` | no |
| workspace\_access\_properties | Workspace access properties configuration. | <pre>object({<br>    device_type_android    = string<br>    device_type_chromeos   = string<br>    device_type_ios        = string<br>    device_type_linux      = string<br>    device_type_osx        = string<br>    device_type_web        = string<br>    device_type_windows    = string<br>    device_type_zeroclient = string<br>  })</pre> | <pre>{<br>  "device_type_android": "ALLOW",<br>  "device_type_chromeos": "ALLOW",<br>  "device_type_ios": "ALLOW",<br>  "device_type_linux": "ALLOW",<br>  "device_type_osx": "ALLOW",<br>  "device_type_web": "ALLOW",<br>  "device_type_windows": "ALLOW",<br>  "device_type_zeroclient": "ALLOW"<br>}</pre> | no |
| workspace\_creation\_properties | Workspace creation properties configuration. | <pre>object({<br>    custom_security_group_id            = string<br>    default_ou                          = string<br>    enable_internet_access              = bool<br>    enable_maintenance_mode             = bool<br>    user_enabled_as_local_administrator = bool<br>  })</pre> | <pre>{<br>  "custom_security_group_id": "",<br>  "default_ou": "",<br>  "enable_internet_access": true,<br>  "enable_maintenance_mode": false,<br>  "user_enabled_as_local_administrator": true<br>}</pre> | no |
| workspaces\_role\_name | The name of the IAM role for AWS WorkSpaces. It must be 'workspaces\_DefaultRole' to meet AWS requirements. | `string` | `"workspaces_DefaultRole"` | no |

## Outputs

| Name | Description |
|------|-------------|
| directory\_id | outputs of workspaces directory |
| directory\_name | directory name. |

