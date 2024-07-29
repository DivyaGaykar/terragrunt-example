terraform {
  source = "../..//modules/app"
}

include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}


dependency "base" {
  config_path = "../base"
  mock_outputs = {
    vpc_id = "sample-vpc-id",
    pri_sub_id_b = "sample-subnet-id"
  }
}


inputs = {
  region = "ap-south-1"

  prefix = "jenkins"

  app_prefix = "backend-q"

  vpc_id = dependency.base.outputs.vpc_id

  subnet_id = dependency.base.outputs.pri_sub_id_b

  ingress_from_port = 8082

  ingress_to_port = 8082

  ingress_protocol = "tcp"

  ingress_cidr = "10.5.0.0/16"
}