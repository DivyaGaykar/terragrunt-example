terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

data "aws_ami" "amazon_linux_2" {
 most_recent = true

 filter {
   name   = "name"
   values = ["al2023-ami-2023*"]
 }

 filter {
   name = "architecture"
   values = ["x86_64"]
 }

 owners = ["amazon"] #amazon
}

resource "aws_instance" "front_end" {
  ami           = "${data.aws_ami.amazon_linux_2.id}"
  instance_type = "${var.instance_type}"
  #key_name      = "${aws_key_pair.ssh_key.key_name}"
  key_name      = "sanket-mumbai"
  
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }


#  iam_instance_profile = "${var.prefix}_news_host"

  availability_zone = "${var.region}a"

  /*
  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    "${aws_security_group.front_end_sg.id}",
    "${aws_security_group.ssh_access.id}"
  ]
  */
  tags = {
    Name = "${var.prefix}-${var.ec2-name}"
    createdBy = "infra-${var.prefix}/news"
  }

}