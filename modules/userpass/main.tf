resource "vault_auth_backend" "userpass" {
  count = var.create_userpass ? 1 : 0

  type = "userpass"
  path = var.path

  tune {
    default_lease_ttl = var.default_lease_ttl
    max_lease_ttl     = var.max_lease_ttl
  }
}

# Creates users
resource "vault_generic_endpoint" "users" {
  for_each = var.users


  depends_on = [vault_auth_backend.userpass[0]]

  path                 = "auth/${var.path}/users/${each.key}"
  ignore_absent_fields = true

  data_json = jsonencode({
    "policies" : coalescelist(var.policies, ["default"]),
    "password" : each.value,
    "token_no_default_policy" : true,
  })
}
