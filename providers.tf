terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.2"
    }
  }
}

provider "restapi" {
  uri = var.api_uri

  # # Unused with API_KEY
  # oauth_client_credentials {
  #   oauth_client_id      = var.oauth_client_id
  #   oauth_client_secret  = var.oauth_client_secret
  #   oauth_token_endpoint = var.oauth_token_endpoint
  #   oauth_scopes         = var.oauth_scopes
  # }

  insecure = true

  headers = {
    "X-CSM-API-KEY" = var.api_key,
    "Content-Type"  = "application/yaml"
  }

  write_returns_object = true
  debug                = true # TODO: remove in production
  update_method        = "PATCH"
}