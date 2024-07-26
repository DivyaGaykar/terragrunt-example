variable "from_port" {
  default = 22
}

variable "to_port" {
    default = 22
}

variable "prefix" {
  default = "jenkins"
}

variable "sg-name" {
  default = "dev-ssh-access-sg"
}