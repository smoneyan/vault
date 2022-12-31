terraform {
  required_version = ">= 1.0"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.11.0"
    }
  }
}

provider "vault" {
  # Configuration options
  # Start the vault server in dev mode `vault server -dev -dev-root-token-id="root"`
  # Set env variable VAULT_ADDR `export VAULT_ADDR=http://127.0.0.1:8200` 
  # Set env variable VAULT_TOKEN `export VAULT_TOKEN=root`
}
