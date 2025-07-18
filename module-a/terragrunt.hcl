include {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "../main.tf"
}

locals {
  env_skip = get_env("SKIP_MODULE_A", "")
  input_skip = try(input("skip_module"), false)
  should_skip = (
    (local.env_skip == "true") || 
    (local.input_skip == true)
  )

  skip_message = "User defined variable value as ${local.env_skip != "" ? local.env_skip : "not set"}"
}

inputs = {
  module_name = "module-a"
  resource_id = "resource-001"
  skip_module = false  # can override via CLI or .tfvars
}

skip = local.should_skip

output "env_skip_debug_message" {
  value = local.skip_message
}
