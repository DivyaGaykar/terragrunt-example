variable "egress_from_port" {
  default = 0
}

variable "egress_to_port" {
    default = 0
}

variable "prefix" {
  default = "jenkins"
}

variable "egress_sg-name" {
  default = "dev-outbound-access-sg"
}

variable "egress_protocol" {
    default = "-1"
}

variable "egress_cidr_blocks" {
   default = "0.0.0.0/0"
}
