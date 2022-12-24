variable "kv_version" {
  type        = string
  description = "Version of kv store that will be enabled"
  default     = "v2"
}

variable "path" {
  type        = string
  description = "Path at which the secret engine will be enabled"
  default     = "kv"
}

variable "secrets" {
  type        = map(string)
  description = "Map of key/value pairs that will be sotred as secrets"
}
