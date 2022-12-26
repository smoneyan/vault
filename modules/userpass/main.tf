resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

# Creates users
resource "vault_generic_endpoint" "users" {
  for_each = var.users

  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/${each.key}"
  ignore_absent_fields = true

  data_json = jsonencode({
    "policies" : coalescelist(var.policies, ["default"]),
    "password" : each.value,
  })
}
