provider "aws" {
    region = "ap-south-1"  
} 

module "front-end-ssh-access-sg" {
  source = "../modules/sg-ingress"
  ingress_sg-name = "${var.app_prefix}-ssh-access-sg"
  
}

output "front-end-ssh-access-sg-id" {
  value = module.front-end-ssh-access-sg.ingress-sg-id
}

module "front-end-internal-sg" {
  source = "../modules/sg-ingress"
  ingress_sg-name = "${var.app_prefix}-internal-sg"
  ingress_from_port = 8080
  ingress_to_port =  8080
}

output "front-end-internal-sg-id" {
  value = module.front-end-internal-sg.ingress-sg-id
}

module "front-end-outbound-sg" {
  source = "../modules/sg-egress"
  egress_sg-name = "${var.app_prefix}-outbound-sg"
}

output "front-end-outbound-sg-id" {
  value = module.front-end-outbound-sg.egress-sg-id
}

module "news-ec2" {
    source = "../modules/ec2"
    app_prefix = "${var.app_prefix}"
    ec2_security_group_ids = ["${module.front-end-ssh-access-sg.ingress-sg-id}", "${module.front-end-internal-sg.ingress-sg-id}", "${module.front-end-outbound-sg.egress-sg-id}"] 
}