terraform {
  required_version = ">= 1.0"

  required_providers {
    # ...
  }

  cloud {
    organization = "sph"

    workspaces {
      # Fixed name
      name = "platform-eng-tfe-workspaces"
      # or
      # tags = [
      #   "team:platform-eng",
      #   "application:tfe",
      #   "component:workspaces",
      #   "environment:prod",
      # ]
    }
  }
}
