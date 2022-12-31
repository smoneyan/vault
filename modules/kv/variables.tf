variable "kv_version" {
  type        = number
  description = "Version of kv store that will be enabled. Accepted values are 1 & 2"
  default     = 2
  validation {
    condition     = contains([1, 2], var.kv_version)
    error_message = "Valid values for kv_version are 1 or 2"
  }
}

variable "path" {
  type        = string
  description = "Path at which the secret engine will be enabled"
  default     = "kv"
}

# variable "secret_name" {
#   type        = string
#   description = "Secret name"
#   default     = "secret"
# }

# variable "secrets" {
#   type        = map(string)
#   description = "Map of key/value pairs that will be sotred as secrets"
# }


variable "enable_engine" {
  type        = bool
  description = "Feature flag to enable secret engine. Otherwise assumption is the engine is already mounted"
  default     = true
}

variable "secret_data" {
  type = map(object({
    path    = string
    secrets = map(string)
  }))
  description = "Feature flag to enable secret engine. Otherwise assumption is the engine is already mounted"
}
