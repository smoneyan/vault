module "vault_local" {
  source = "../../modules/kv"

  kv_version = "2"
  path       = "kv-secret2"
  secrets = {
    username = "admin"
    password = "password2"
  }
}

module "transit_local" {
  source = "../../modules/transit"
}
