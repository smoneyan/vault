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

module "users" {
  source = "../../modules/userpass"

  create_userpass = true
  users = {
    admin = "password"
  }
  policies = ["first_policy"]
}

module "approle" {
  source    = "../../modules/approle"
  role_name = "jenkins"
  policies  = ["jenkins_policy"]
}
