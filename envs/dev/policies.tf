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
    path         = "auth/token/lookup-self"
    capabilities = ["read"]
    description  = "Allow to lookup token info"
  }

  rule {
    path         = "auth/token/lookup"
    capabilities = ["update"]
    description  = "Allow to read other token information"
  }

  rule {
    path         = "kv-secret2/metadata"
    capabilities = ["list"]
    description  = "Allow lsiting kv secret"
  }
  rule {
    path         = "kv-secret2/data/secret"
    capabilities = ["read", "create", "update"]
    description  = "Allow reading kv secret"
  }
  rule {
    path         = "kv-secret2/metadata/secret"
    capabilities = ["read", "delete"]
    description  = "Allow reading kv secret versions and delete all version"
  }
  rule {
    path         = "kv-secret2/+/second-secret"
    capabilities = ["read", "create", "update"]
    description  = "Allow reading kv secret"
  }
  rule {
    path         = "kv-secret2/destroy/secret"
    capabilities = ["update"]
    description  = "Allow deleting kv secret individual version"
  }

}

resource "vault_policy" "first_policy" {
  name   = "first_policy"
  policy = data.vault_policy_document.first_policy_doc.hcl
}



data "vault_policy_document" "jenkins_policy_doc" {
  rule {
    path         = "kv-secret2/*"
    capabilities = ["create", "read", "update", "delete"]
    description  = "Allow lsiting kv secret"
  }

  rule {
    path         = "auth/token/create"
    capabilities = ["update"]
  }
}

resource "vault_policy" "jenkins_policy" {
  name   = "jenkins_policy"
  policy = data.vault_policy_document.jenkins_policy_doc.hcl
}
