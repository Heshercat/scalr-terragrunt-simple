include {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "../main.tf"
}

locals {
  # Based on environment variables
  exclude_d_from_plan_and_apply   = get_env("EXCLUDE_D_PLAN_APPLY", "false") == "true"
  exclude_d_from_destroy          = get_env("EXCLUDE_D_DESTROY", "false") == "true"
  exclude_d_but_allow_output      = get_env("EXCLUDE_D_ALL_EXCEPT_OUTPUT", "false") == "true"
  exclude_d_for_dev_environment   = get_env("ENV", "") == "dev"  # Example env context
}

exclude {
  if = local.exclude_d_from_plan_and_apply
  actions = ["plan", "apply"]
  exclude_dependencies = false
}

exclude {
  if = local.exclude_d_from_destroy
  actions = ["destroy"]
  exclude_dependencies = true
}

exclude {
  if = local.exclude_d_but_allow_output
  actions = ["all_except_output"]
  exclude_dependencies = false
}

exclude {
  if = local.exclude_d_for_dev_environment
  actions = ["all"]
  exclude_dependencies = true
}
