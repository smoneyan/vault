output "approle_role_id" {
  value = vault_approle_auth_backend_role.role
}

output "approle_secret_id" {
  #For demo purpose, explicitly making it nonsensitive
  value = nonsensitive(vault_approle_auth_backend_role_secret_id.secret.secret_id)
}
