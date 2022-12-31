variable "path" {
  type        = string
  description = "Path at which the transit engine will be enabled"
  default     = "transit"
}

variable "key_name" {
  type        = string
  description = "The name to identify this key within the backend. Must be unique within the backend."
  default     = "demo-key"
}

variable "type" {
  type    = string
  default = "aes256-gcm96"
}

variable "create_policies" {
  type    = bool
  default = true
}
