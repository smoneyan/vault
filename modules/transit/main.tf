resource "vault_mount" "transit" {
  path                      = var.path
  type                      = "transit"
  description               = "Transit secret engine"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

resource "vault_transit_secret_backend_key" "key" {
  backend = vault_mount.transit.path
  name    = var.key_name
  type    = var.type
}
