terraform {
  source = "../../../modules/ec2"
}

include "root" {
  path = find_in_parent_folders()
}


inputs = {
  region = "ap-south-1"

  instance_type = "t2.micro"

  prefix = "jenkins"

  ec2-name = "dev-backend-ec2"
}