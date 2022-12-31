data "vault_policy_document" "entity_policy_doc" {
  rule {
    path         = "kv-secret2/*"
    capabilities = ["create", "read", "update", "delete"]
    description  = "Allow lsiting kv secret"
  }
}

resource "vault_policy" "entity_policy" {
  name   = "entity_policy"
  policy = data.vault_policy_document.entity_policy_doc.hcl
}

data "vault_policy_document" "smoneyan_policy" {
  rule {
    path         = "kv-secret2/*"
    capabilities = ["create", "read", "update", "delete"]
    description  = "Allow lsiting kv secret"
  }
}

resource "vault_policy" "smoneyan_policy" {
  name   = "smoneyan_policy"
  policy = data.vault_policy_document.smoneyan_policy.hcl
}

data "vault_policy_document" "subu_policy" {
  rule {
    path         = "kv-secret2/*"
    capabilities = ["create", "read", "update", "delete"]
    description  = "Allow lsiting kv secret"
  }
}

resource "vault_policy" "subu_policy" {
  name   = "subu_policy"
  policy = data.vault_policy_document.subu_policy.hcl
}

module "smoneyan" {
  source          = "../../modules/userpass"
  create_userpass = true
  path            = "userpass-smoneyan"
  users = {
    smoneyan = "password"
  }
  policies = ["smoneyan_policy", "transit_engine_policy"]
}

module "subu" {
  source          = "../../modules/userpass"
  create_userpass = true
  path            = "userpass-subu"
  users = {
    subu = "password"
  }
  policies = ["subu_policy"]
}

module "subu_entity" {
  source = "../../modules/entity"

  entity_name     = "subu_entity"
  entity_policies = ["entity_policy"]
  aliases = {
    smoneyan = {
      auth_method = "userpass-smoneyan"
      entity_name = "subu_entity"
      policies    = ["smoneyan_policy"]
    },
    subu = {
      auth_method = "userpass-subu"
      entity_name = "subu_entity"
      policies    = ["subu_policy"]
    }
  }
}
