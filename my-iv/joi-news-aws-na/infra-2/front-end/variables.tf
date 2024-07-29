variable "region" {
  default = "ap-south-1"
}

variable "ingress_sg-name" {
  default = "frontend-ssh-access-sg"
}

variable "egress_sg-name" {
  default = "frontend-outbound-access-sg"
}

variable "app_prefix" {
  default = "frontend"
}

variable "ingress_from_port" {
  default = 8080
}

variable "ingress_to_port" {
  default = 8080
}