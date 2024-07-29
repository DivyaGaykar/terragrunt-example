terraform {
  source = "../..//modules/base"
}

include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

inputs = {
  region = "ap-south-1"

  prefix = "jenkins"
}