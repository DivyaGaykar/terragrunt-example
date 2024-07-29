provider "aws" {
    region = "ap-south-1"  
}

module "base-infra" {
  source = "../modules/base"
}

output "repository_base_url" {
  value = module.base-infra.repository_base_url
}