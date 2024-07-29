variable "ingress_from_port" {
  default = 22
}

variable "ingress_to_port" {
    default = 22
}

variable "prefix" {
  default = "jenkins"
}

variable "ingress_sg-name" {
  default = "dev-ssh-access-sg"
}

variable "ingress_protocol" {
  default = "tcp"
  
}

variable "ingress_cidr_blocks" {
  default = "0.0.0.0/0"
  
}