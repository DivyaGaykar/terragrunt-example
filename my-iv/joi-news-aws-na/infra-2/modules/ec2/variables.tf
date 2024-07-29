variable "region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "prefix" {
  default = "jenkins"
}

variable "app_prefix" {
  default = "frontend"
}

variable "subnet_id" {
  default = "10.0.0.0/24"
}

variable "ec2_security_group_ids" {
  type = list(string)
  default = ["mock-sg-id"]
}