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
  # Set env variable VAULT_ADDR
  # Set env variable VAULT_TOKEN
}
