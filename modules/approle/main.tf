resource "vault_auth_backend" "approle" {
  type = "approle"
  path = var.path
  tune {
    default_lease_ttl = var.default_lease_ttl
    max_lease_ttl     = var.max_lease_ttl
  }
}

resource "vault_approle_auth_backend_role" "role" {
  backend        = vault_auth_backend.approle.path
  role_name      = var.role_name
  token_policies = coalescelist(var.policies, ["default"])
}

resource "vault_approle_auth_backend_role_secret_id" "secret" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.role.role_name
}
