output "organization_id" {
  value = restapi_object.create_organization.api_data.id
}

output "solution_id" {
  value = restapi_object.create_solution.api_data.id
}

output "workspace_id" {
  value = restapi_object.create_workspace.api_data.id
}

output "scenario_id" {
  value = restapi_object.create_scenario.api_data.id
}

output "run_id" {
  value = restapi_object.run_scenario.api_data.id
}