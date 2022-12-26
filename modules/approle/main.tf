resource "vault_auth_backend" "approle" {
  type = "approle"
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
