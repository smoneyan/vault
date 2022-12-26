variable "path" {
  type        = string
  description = "Path at which the transit engine will be enabled"
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
