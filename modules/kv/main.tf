resource "vault_mount" "kv" {
  count = var.enable_engine ? 1 : 0

  path        = var.path
  type        = "kv"
  options     = { version = var.kv_version }
  description = "KV Version ${var.kv_version} secret engine mount"
}

resource "vault_kv_secret_v2" "secret" {
  for_each = var.secret_data

  mount               = vault_mount.kv[0].path
  name                = each.value.path
  delete_all_versions = true
  data_json           = jsonencode(each.value.secrets)
}

# resource "vault_kv_secret" "secret" {
#   count = (var.kv_version == 1) ? 1 : 0

#   path      = "${vault_mount.kv[0].path}/${var.secret_name}"
#   data_json = jsonencode(var.secrets)
# }
