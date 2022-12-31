variable "create_userpass" {
  type        = bool
  description = "checks whether userpass mount needs to be created or not"
  default     = false
}
variable "path" {
  type        = string
  description = "Path at which the userpass auth will be enabled"
  default     = "userpass"
}


variable "users" {
  type        = map(string)
  description = "Map of usernames/passwords for users to be created"
}

variable "policies" {
  type        = list(string)
  description = "list of policies"
  default     = ["default"]
}
