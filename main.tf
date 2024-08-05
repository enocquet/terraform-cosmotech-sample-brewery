resource "restapi_object" "create_organization" {
  data = templatefile("${path.module}/templates/organization.json", {
    user_email = var.user_email,
  })
  path = "/organizations"
}

resource "time_sleep" "wait_15_seconds_after_organization" {
  depends_on = [restapi_object.create_organization]

  create_duration = "15s"
}

resource "restapi_object" "create_solution" {
  data = templatefile("${path.module}/templates/solution.json", {
    user_email = var.user_email,
  })
  path = "/organizations/${restapi_object.create_organization.api_data.id}/solutions"

  depends_on = [time_sleep.wait_15_seconds_after_organization]
}

resource "time_sleep" "wait_15_seconds_after_solution" {
  depends_on = [restapi_object.create_solution]

  create_duration = "15s"
}

resource "restapi_object" "create_workspace" {
  data = templatefile("${path.module}/templates/workspace.json", {
    solution     = restapi_object.create_solution.api_data.id,
    organization = restapi_object.create_organization.api_data.id,
    user_email   = var.user_email
  })
  path = "/organizations/${restapi_object.create_organization.api_data.id}/workspaces"

  depends_on = [time_sleep.wait_15_seconds_after_solution]
}

resource "time_sleep" "wait_15_seconds_after_workspace" {
  depends_on = [restapi_object.create_workspace]

  create_duration = "15s"
}

resource "restapi_object" "create_scenario" {
  data = templatefile("${path.module}/templates/scenario.json", {
    user_email = var.user_email
  })
  path = "/organizations/${restapi_object.create_organization.api_data.id}/workspaces/${restapi_object.create_workspace.api_data.id}/runners"

  depends_on = [time_sleep.wait_15_seconds_after_workspace]
}

resource "time_sleep" "wait_15_seconds_after_scenario" {
  depends_on = [restapi_object.create_scenario]

  create_duration = "15s"
}

resource "restapi_object" "run_scenario" {
  data = ""
  path = "/organizations/${restapi_object.create_organization.api_data.id}/workspaces/${restapi_object.create_workspace.api_data.id}/runners/${restapi_object.create_scenario.api_data.id}/start"

  depends_on = [time_sleep.wait_15_seconds_after_scenario]
}