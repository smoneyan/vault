module "group" {
  source = "../../modules/group"
  
  group_name = "devops"
  group_members = ["alice_entity", "bob_entity"]
  group_policies = ["group_policy"]
}

data "vault_policy_document" "group_policy_doc" {
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

resource "vault_policy" "group_policy" {
  name   = "group_policy"
  policy = data.vault_policy_document.group_policy_doc.hcl
}
