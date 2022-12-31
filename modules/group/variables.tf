variable "group_name" {
  type        = string
  description = "entity name"
  default     = "admin"
}

variable "group_policies" {
  type        = list(string)
  description = "Group policies"
  default     = []
}

variable "group_members" {
  type = set(string)
  default = [ "alice_entity", "bob_enitty"]
}
