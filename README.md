<!-- BEGIN_TF_DOCS -->


```markdown
# Deploy Cosmo Tech Sample Brewery Solution

Configuration of a "brewery" solution on a Cosmo Tech Platform.

## Prerequisites

- A running Kubernetes cluster
- Cosmo Tech Platform installed on it (see [here](https://artifacthub.io/packages/helm/cosmotech-api/cosmotech-api))
- The docker image of the brewery simulation (see [here](https://github.com/Cosmo-Tech/onboarding-brewery-solution/pkgs/container/brewery_simulator))


## Usage

You need the KUBE_CONFIG_FILE with default target cluster and context.

Ensure the brewery image is accessible in the container registry defined in the values of the Cosmo Tech API under 'argo' :
```bash
argo:
  imageCredentials:
    registry: ghcr.io/cosmo-tech
```
and under 'config' : 
```bash
config:
  csm:
    platform:
      containerRegistry:
        checkSolutionImage: false
        host: ghcr.io/cosmo-tech
```


You now have two options : 

#### 1. Using API_KEY : 

Be sure to have configured the API_KEY option in the Cosmo Tech API with these minimal values :
```bash
list_apikey_allowed = [{
  name           = "API Key"
  apiKey         = "API_KEY"
  associatedRole = "Platform.Admin"
  securedUris = [
    "/organizations",
    "/organizations/.*",
    "/organizations/.*/workspaces",
    "/organizations/.*/workspaces/.*",
    "/organizations/.*/solutions",
    "/organizations/.*/solutions/.*",
    "/organizations/.*/workspaces/.*/runners",
    "/organizations/.*/workspaces/.*/runners/.*",
    "/organizations/.*/workspaces/.*/runners/.*/start",
  ]
}]

```

Then configure the Terraform provider with the following parameters :
```bash
provider "restapi" {
  uri = var.api_uri

  insecure = true

  headers = {
    "X-CSM-API-KEY" = var.api_key,
    "Content-Type"  = "application/yaml"
  }

  write_returns_object = true
  debug                = true
  update_method        = "PATCH"
}

```


#### 2. Using Identity Provider : 

Pass the required informations to the Terraform provider as follow :
```bash
provider "restapi" {
  uri = var.api_uri

  # Unused with API_KEY
  oauth_client_credentials {
    oauth_client_id      = var.oauth_client_id
    oauth_client_secret  = var.oauth_client_secret
    oauth_token_endpoint = var.oauth_token_endpoint
    oauth_scopes         = var.oauth_scopes
  }

  write_returns_object = true
  debug                = true
  update_method        = "PATCH"
}

```

The next step is to provide values to the required variables of the module. 

For example, using the API_KEY to authenticate, the a minimal configuration should be : 
```bash
api_uri = "<COSMO_TECH_PLATFORM_URL>"
api_key = "<API_KEY_VALUE>"

user_email = "email@smtp.com"

organization_name = "<RANDOM_ORGANIZATION_NAME>"
```

Then, run the classics Terraform commands : 
```bash
# Initialize the module
terraform init

# Create a plan matching your configuration files
terraform plan -out tfplan

# Apply the plan
terraform apply tfplan

```

## Results

The following resources should have been created : 

- An Organization
- A Solution
- A workspace

The Simulation too should be launched. 

TBD

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.
``` 

## Providers

| Name | Version |
|------|---------|
| <a name="provider_restapi"></a> [restapi](#provider\_restapi) | 1.18.2 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_organization_id"></a> [organization\_id](#output\_organization\_id) | n/a |
| <a name="output_run_id"></a> [run\_id](#output\_run\_id) | n/a |
| <a name="output_scenario_id"></a> [scenario\_id](#output\_scenario\_id) | n/a |
| <a name="output_solution_id"></a> [solution\_id](#output\_solution\_id) | n/a |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | The alternative way to use for authentication when working with the Cosmo Tech API.<br>This is not the way to go with Swagger or othen Web oriented interfaces. May be used<br> with tools like Curl or Postman.<br>When working with API\_KEY, the 'classic' way to authenticate is not used. | `string` | n/a | yes |
| <a name="input_api_uri"></a> [api\_uri](#input\_api\_uri) | n/a | `string` | n/a | yes |
| <a name="input_user_email"></a> [user\_email](#input\_user\_email) | n/a | `string` | n/a | yes |
| <a name="input_oauth_client_id"></a> [oauth\_client\_id](#input\_oauth\_client\_id) | n/a | `string` | `""` | no |
| <a name="input_oauth_client_secret"></a> [oauth\_client\_secret](#input\_oauth\_client\_secret) | n/a | `string` | `""` | no |
| <a name="input_oauth_scopes"></a> [oauth\_scopes](#input\_oauth\_scopes) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_oauth_token_endpoint"></a> [oauth\_token\_endpoint](#input\_oauth\_token\_endpoint) | The OAuth token endpoint to use for authentication.<br>e.g for Azure Authentication (Entra ID) : <br>"https://login.microsoftonline.com/<TENANT\_ID>/oauth2/v2.0/token" | `string` | `""` | no |
| <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name) | n/a | `string` | `"Cosmo Tech Sample Organization"` | no |  
<!-- END_TF_DOCS -->