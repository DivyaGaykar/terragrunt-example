variable "region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "prefix" {
  default = "jenkins"
}

variable "ec2-name" {
  default = "dev-ec2"
}

variable "user_data" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "vpc_id" {
  default = ""
}