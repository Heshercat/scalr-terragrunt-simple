terraform {
  source = "../main.tf"
}

include {
  path = find_in_parent_folders("backend.hcl")
}



inputs = {
  module_name = "module-e"
  resource_id = "resource-003"
}