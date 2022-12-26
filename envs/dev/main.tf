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
  users = {
    admin = "password"
  }
  policies = ["default", "first_policy"]
}

data "vault_policy_document" "first_policy_doc" {
  rule {
    path         = "sys/mounts"
    capabilities = ["read"]
    description  = "Allow listing secret engines"
  }

  rule {
    path         = "sys/policies/acl/*"
    capabilities = ["list", "read"]
    description  = "Allow listing policies"
  }

  rule {
    path         = "sys/auth"
    capabilities = ["read"]
    description  = "Allow listing auth methods"
  }

  rule {
    path         = "kv-secret2/metadata"
    capabilities = ["list", "read"]
    description  = "Allow reading kv secret"
  }
  rule {
    path         = "kv-secret2/+/secret"
    capabilities = ["read"]
    description  = "Allow reading kv secret"
  }
}

resource "vault_policy" "first_policy" {
  name   = "first_policy"
  policy = data.vault_policy_document.first_policy_doc.hcl
}
