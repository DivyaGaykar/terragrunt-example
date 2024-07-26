variable "from_port" {
  default = 80
}

variable "to_port" {
    default = 80
}

variable "sg-name" {
  default = "app-ssh-access-sg"
}

variable "ec2-name" {
  default = "app-ec2"
}

variable "prefix" {
  default = "jenkins"
}