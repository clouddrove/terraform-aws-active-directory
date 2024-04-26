## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ad\_name | The fully qualified name for the directory, such as corp.example.com | `string` | `"corp.example.com"` | no |
| ad\_password | The password for the directory administrator or connector user. | `string` | `"xyzsf58f5fqar"` | no |
| ad\_size | The size of the directory (Small or Large are accepted values). | `string` | `"Small"` | no |
| alias | The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values). | `string` | `""` | no |
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| change\_compute\_type | Whether WorkSpaces directory users can change the compute type (bundle) for their workspace. | `bool` | `true` | no |
| connect\_settings | (Required for ADConnector) Connector related information about the directory. Fields documented below. | `map(string)` | `{}` | no |
| custom\_policy | Custom policy ARN | `string` | `""` | no |
| description | A textual description for the directory. | `string` | `"Default Active Directory"` | no |
| device\_type\_android | Indicates whether users can use Android devices to access their WorkSpaces. | `string` | `"ALLOW"` | no |
| device\_type\_chromeos | Indicates whether users can use Chromebooks to access their WorkSpaces. | `string` | `"ALLOW"` | no |
| device\_type\_ios | Indicates whether users can use iOS devices to access their WorkSpaces. | `string` | `"ALLOW"` | no |
| device\_type\_linux | Indicates whether users can use Linux devices to access their WorkSpaces. | `string` | `"ALLOW"` | no |
| device\_type\_osx | Indicates whether users can use macOS clients to access their WorkSpaces. | `string` | `"ALLOW"` | no |
| device\_type\_web | Indicates whether users can access their WorkSpaces through a web browser. | `string` | `"ALLOW"` | no |
| device\_type\_windows | Indicates whether users can use Windows clients to access their WorkSpaces. | `string` | `"ALLOW"` | no |
| device\_type\_zeroclient | Indicates whether users can use zero client devices to access their WorkSpaces. | `string` | `"ALLOW"` | no |
| edition | The MicrosoftAD edition (Standard or Enterprise). | `string` | `"Standard"` | no |
| enable\_internet\_access | Indicates whether internet access is enabled for your WorkSpaces. | `bool` | `false` | no |
| enable\_maintenance\_mode | Indicates whether maintenance mode is enabled for your WorkSpaces. | `bool` | `false` | no |
| enable\_sso | Whether to enable single-sign on for the directory. Requires alias. | `bool` | `false` | no |
| enabled | Flag to control the module creation. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| increase\_volume\_size | Whether WorkSpaces directory users can increase the volume size of the drives on their workspace. | `bool` | `true` | no |
| ip\_whitelist | List of IP's to for whitelist | `list(string)` | <pre>[<br>  "51.79.69.69/32"<br>]</pre> | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| managedby | ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'. | `string` | `"anmol@clouddrove.com"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| rebuild\_workspace | Whether WorkSpaces directory users can rebuild the operating system of a workspace to its original state. | `bool` | `true` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-active-directory"` | no |
| restart\_workspace | Whether WorkSpaces directory users can restart their workspace. | `bool` | `true` | no |
| short\_name | The short name of the directory, such as CORP. | `string` | `"CORP"` | no |
| subnet\_ids | List of subnets in VPC | `list(string)` | `null` | no |
| switch\_running\_mode | Whether WorkSpaces directory users can switch the running mode of their workspace. | `bool` | `true` | no |
| type | The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values). | `string` | `"SimpleAD"` | no |
| user\_enabled\_as\_local\_administrator | Indicates whether users are local administrators of their WorkSpaces. | `bool` | `false` | no |
| vpc\_settings | (Required for SimpleAD and MicrosoftAD) VPC related information about the directory. Fields documented below. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| directory\_id | outputs of workspaces directory |
| directory\_name | directory name. |

