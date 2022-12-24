resource "vault_mount" "kvv2" {
  count       = (var.kv_version == "v2") ? 1 : 0

  path        = var.path
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

resource "vault_kv_secret_v2" "secret" {
  count = (var.kv_version == "v2") ? 1 : 0

  mount               = vault_mount.kvv2[0].path
  name                = "secret"
  cas                 = 1
  delete_all_versions = true
  data_json           = jsonencode(var.secrets)
}
