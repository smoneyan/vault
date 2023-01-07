module "vault_local" {
  source = "../../modules/kv"

  kv_version = "2"
  path       = "kv-secret2"
  secret_data = {
    secret = {
      path = "secret"
      secrets = {
        username = "admin"
        password = "password2"
      }
    }

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
    alice = "password"
    bob   = "password"
  }
  policies          = ["first_policy", "default"]
  default_lease_ttl = "30s"
  max_lease_ttl     = "60s"
}

module "approle" {
  source            = "../../modules/approle"
  role_name         = "jenkins"
  policies          = ["jenkins_policy"]
  default_lease_ttl = "30s"
  max_lease_ttl     = "60s"
}

resource "vault_audit" "test" {
  type = "file"

  options = {
    file_path = "/tmp/vault-audit.log"
  }
}
