variable "instance_type" {
  default = "t2.micro"
}
variable "docker_image_tag" {
  default = "latest"
}
variable "prefix" {
  default = "jenkins"
}

variable "app_prefix" {
  default = "frontend"
}

variable "vpc_id" {
  default = "10.0.0.0/16"
}

variable "subnet_id" {
  default = "10.0.0.0/24"
}

variable "ingress_from_port" {
  default = 8080
}

variable "ingress_to_port" {
  default = 8080
}

variable "ingress_protocol" {
  default = "tcp"
}

variable "ingress_cidr" {
  default = "0.0.0.0/0"
}

variable "s3_website_endpoint" {
  default = "sample-s3-url"
}

variable "quotes_instance_private_ip" {
  default = "10.10.10.10"
}

variable "newsfeed_instance_private_ip" {
  default = "11.11.11.11"
}

variable "user_data" {
  default = ""
}