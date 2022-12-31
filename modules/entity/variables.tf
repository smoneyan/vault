variable "entity_name" {
  type        = string
  description = "entity name"
  default     = "admin"
}

variable "entity_policies" {
  type        = list(string)
  description = "Entity policies"
  default     = []
}

variable "aliases" {
  type = map(object({
    entity_name = string
    auth_method = string
    policies    = list(string)
  }))
  description = "users with the auth method"
  default = {
    admin = {
      entity_name = "admin"
      auth_method = "userpass"
      policies    = []
    }
  }
}
