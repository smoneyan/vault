data "vault_policy_document" "token_policy_doc" {
  rule {
    path         = "auth/token/*"
    capabilities = ["create", "read", "update"]
    description  = "Allow managing token"
  }
}

resource "vault_policy" "token_policy" {
  name   = "token_policy"
  policy = data.vault_policy_document.token_policy_doc.hcl
}


module "token_user" {
  source          = "../../modules/userpass"
  create_userpass = false
  path            = "userpass"
  users = {
    token_user = "password"
  }
  policies = ["token_policy"]
}
