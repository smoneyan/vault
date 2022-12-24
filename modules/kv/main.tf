resource "vault_mount" "kv" {
  path        = var.path
  type        = "kv"
  options     = { version = var.kv_version }
  description = "KV Version ${var.kv_version} secret engine mount"
}

resource "vault_kv_secret_v2" "secret" {
  count = (var.kv_version == 2) ? 1 : 0

  mount               = vault_mount.kv.path
  name                = var.secret_name
  delete_all_versions = true
  data_json           = jsonencode(var.secrets)
}

resource "vault_kv_secret" "secret" {
  count = (var.kv_version == 1) ? 1 : 0

  path      = "${vault_mount.kv.path}/${var.secret_name}"
  data_json = jsonencode(var.secrets)
}
