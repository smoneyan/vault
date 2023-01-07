data "vault_policy_document" "entity_policy_doc" {
  rule {
    path         = "entity-secret/metadata"
    capabilities = ["list"]
    description  = "Allow lsiting kv secret"
  }

  rule {
    path         = "entity-secret/+/{{identity.entity.name}}"
    capabilities = ["create", "update", "read"]
    description  = "Manage own kv secret of entity"
  }
}

resource "vault_policy" "entity_policy" {
  name   = "entity_policy"
  policy = data.vault_policy_document.entity_policy_doc.hcl
}

data "vault_policy_document" "smoneyan_policy" {
  rule {
    path         = "entity-secret/*"
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
    path         = "entity-secret/*"
    capabilities = ["create", "read", "update", "delete"]
    description  = "Allow lsiting kv secret"
  }
}

resource "vault_policy" "subu_policy" {
  name   = "subu_policy"
  policy = data.vault_policy_document.subu_policy.hcl
}

#Creates a user (smoneyan) in userpass-smoneyan mount
module "smoneyan" {
  source          = "../../modules/userpass"
  create_userpass = true
  path            = "userpass-smoneyan"
  users = {
    smoneyan = "password"
  }
  policies = ["smoneyan_policy", "transit_engine_policy"]

  depends_on = [
    module.transit_local
  ]
}

#Creates a user (subu) in userpass-subu mount

module "subu" {
  source          = "../../modules/userpass"
  create_userpass = true
  path            = "userpass-subu"
  users = {
    subu = "password"
  }
  policies = ["subu_policy"]
}

#Creates an entity and maps the 2 users created above.
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

  depends_on = [
    module.users
  ]
}

module "bob_entity" {
  source = "../../modules/entity"

  entity_name     = "bob_entity"
  entity_policies = ["entity_policy"]
  aliases = {
    bob = {
      auth_method = "userpass"
      entity_name = "bob_entity"
      policies    = ["smoneyan_policy"]
    }
  }

  depends_on = [
    module.users
  ]
}

module "alice_entity" {
  source = "../../modules/entity"

  entity_name     = "alice_entity"
  entity_policies = ["entity_policy"]
  aliases = {
    alice = {
      auth_method = "userpass"
      entity_name = "alice_entity"
      policies    = ["smoneyan_policy"]
    }
  }

  depends_on = [
    module.users
  ]
}

module "policy_template_secrets" {
  source = "../../modules/kv"

  kv_version    = "2"
  path          = "entity-secret"
  enable_engine = true

  secret_data = {
    alice_entity = {
      path = "alice_entity"
      secrets = {
        username = "alice"
        password = "password"
      }
    },
    bob_entity = {
      path = "bob_entity"
      secrets = {
        username = "bob"
        password = "password"
      }
    }
  }
}
