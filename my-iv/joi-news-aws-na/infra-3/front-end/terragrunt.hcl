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
    pub_sub_id_a = "sample-subnet-id"
    s3_website_endpoint = "sample-s3-endpoint"
  }
}

dependency "quotes" {
  config_path = "../quotes"
  mock_outputs = {
    app_instance_private_ip = "10.10.10.10"
  }
  
}

dependency "newsfeed" {
  config_path = "../newsfeed"
  mock_outputs = {
    app_instance_private_ip = "11.11.11.11"
  }
  
}

inputs = {
  region = "ap-south-1"

  prefix = "jenkins"

  app_prefix = "frontend"

  vpc_id = dependency.base.outputs.vpc_id

  subnet_id = dependency.base.outputs.pub_sub_id_a

  ingress_from_port = 8080

  ingress_to_port = 8080

  ingress_protocol = "tcp"

  ingress_cidr = "0.0.0.0/0"

  s3_website_endpoint = dependency.base.outputs.s3_website_endpoint

  quotes_instance_private_ip = dependency.quotes.outputs.app_instance_private_ip

  newsfeed_instance_private_ip = dependency.newsfeed.outputs.app_instance_private_ip

}