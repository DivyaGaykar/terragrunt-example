
module "app-ssh-access-sg" {
  source = "../..//modules/sg-ingress"
}

output "app-ssh-access-sg-id" {
  value = module.app-ssh-access-sg.sg-id
}

module "app-internal-sg" {
  source = "../..//modules/sg-ingress"
}

output "app-internal-sg-id" {
  value = module.app-internal-sg.sg-id
}

module "app-ec2" {
    source = "../..//modules/ec2"
}

