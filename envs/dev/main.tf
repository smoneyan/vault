module "vault_local" {
  source = "../../modules/kv"

  kv_version = "v2"
  secrets = {
    username = "admin"
    password = "password2"
  }
}
