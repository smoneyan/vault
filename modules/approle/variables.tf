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
