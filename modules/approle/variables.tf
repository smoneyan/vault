variable "path" {
  type        = string
  description = "Path at which the approle will be enabled"
  default     = "approle"
}


variable "role_name" {
  type        = string
  description = "Role name to be created"
}

variable "policies" {
  type        = list(string)
  description = "list of policies"
  default     = ["default"]
}

variable "default_lease_ttl" {
  type        = string
  description = "checks whether userpass mount needs to be created or not"
  default     = "768h"
}

variable "max_lease_ttl" {
  type        = string
  description = "checks whether userpass mount needs to be created or not"
  default     = "768h"
}
