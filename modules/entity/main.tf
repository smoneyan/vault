resource "vault_identity_entity" "entity" {
  name              = var.entity_name
  external_policies = true
}

resource "vault_identity_entity_policies" "default" {
  policies = var.entity_policies

  exclusive = false

  entity_id = vault_identity_entity.entity.id
}

resource "vault_identity_entity_alias" "aliases" {
  for_each = var.aliases

  name           = each.key
  mount_accessor = data.vault_auth_backend.auth_backend[each.key].accessor
  canonical_id   = vault_identity_entity.entity.id
}

data "vault_auth_backend" "auth_backend" {
  for_each = var.aliases

  path = each.value.auth_method
}
