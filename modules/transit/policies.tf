data "vault_policy_document" "transit_engine_policy" {
  rule {
    path         = "${var.path}/encrypt/${var.key_name}"
    capabilities = ["read"]
    description  = "Allow encrypting"
  }

  rule {
    path         = "${var.path}/decrypt/${var.key_name}"
    capabilities = ["read"]
    description  = "Allow encrypting"
  }

  rule {
    path         = "${var.path}/keys"
    capabilities = ["list"]
    description  = "To list all the keys in UI"
  }

  rule {
    path         = "${var.path}/keys/demo-key"
    capabilities = ["read"]
    description  = "#To  show all the options under demo-key , so that eencrypt or decrypt option is visible in the UI"
  }

}

resource "vault_policy" "transit_engine_policy" {
  count = var.create_policies ? 1 : 0

  name   = "transit_engine_policy"
  policy = data.vault_policy_document.transit_engine_policy.hcl
}
