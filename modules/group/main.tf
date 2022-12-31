resource "vault_identity_group" "group" {
  name     = var.group_name

  type     = "internal"
  policies = var.group_policies
}

resource "vault_identity_group_member_entity_ids" "members" {

  exclusive         = true
  member_entity_ids = local.ids
  group_id          = vault_identity_group.group.id
}

data "vault_identity_entity" "users" {
  for_each = var.group_members

  entity_name = each.value
}

locals {
  ids = [for user in data.vault_identity_entity.users: user.id]
}
