variable "api_uri" {
  type = string
}

variable "oauth_client_id" {
  type = string
  default = ""
}

variable "oauth_client_secret" {
  type = string
  default = ""
}

variable "oauth_scopes" {
  type = list(string)
  default = [ "" ]
}

variable "organization_name" {
  type = string
}

variable "acl" {
  type = list(map(string))
  default = [{
    "id"   = "john.doe@cosmotech.com"
    "role" = "viewer"
  }]
}

variable "oauth_token_endpoint" {
  type        = string
  default     = ""
  description = <<-EOT
The OAuth token endpoint to use for authentication.
e.g for Azure Authentication (Entra ID) : 
"https://login.microsoftonline.com/<TENANT_ID>/oauth2/v2.0/token"
EOT
}

variable "user_email" {
  type = string
}

variable "api_key" {
  type        = string
  description = <<-EOT
The alternative way to use for authentication when working with the Cosmo Tech API.
This is not the way to go with Swagger or othen Web oriented interfaces. May be used
 with tools like Curl or Postman.
When working with API_KEY, the 'classic' way to authenticate is not used.
EOT
}