resource "aws_security_group" "ssh_access" {
  vpc_id      = var.vpc_id
  name        = "${var.prefix}-${var.app_prefix}-ssh_access"
  description = "SSH access group"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ingress_cidr]
  }

  tags = {
    Name = "${var.prefix}-${var.app_prefix}-ssh_access"
    createdBy = "infra-${var.prefix}/news"
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "${var.prefix}-${var.app_prefix}-news"
  public_key = "${file("${path.module}/../../infra-3/id_rsa.pub")}"
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

### Front end

resource "aws_security_group" "front_end_sg" {
  vpc_id      = var.vpc_id
  name        = "${var.prefix}-${var.app_prefix}-sg"
  description = "Security group for ${var.app_prefix}"

  tags = {
    Name = "${var.prefix}-${var.app_prefix}-sg"
    createdBy = "infra-${var.prefix}/news"
  }
}

# Allow all outbound connections
resource "aws_security_group_rule" "front_end_all_out" {
  type        = "egress"
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = "${aws_security_group.front_end_sg.id}"
}

resource "aws_instance" "front_end" {
  ami           = "${data.aws_ami.amazon_linux_2.id}"
  instance_type = "${var.instance_type}"
  key_name      = "${aws_key_pair.ssh_key.key_name}"
  #associate_public_ip_address = true
  associate_public_ip_address = var.app_prefix == "frontend" ? true : false

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }

  #iam_instance_profile = "${var.prefix}_news_host"

  #availability_zone = "${var.region}a"

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    "${aws_security_group.front_end_sg.id}",
    "${aws_security_group.ssh_access.id}"
  ]

  tags = {
    Name = "${var.prefix}-${var.app_prefix}"
    createdBy = "infra-${var.prefix}/news"
  }

  user_data = templatefile("${path.module}/../../infra-3/provision-${app_prefix}.sh.tftpl", {
    app = var.app_prefix
  })

  /*
  connection {
    host = "${self.public_ip}"
    type = "ssh"
    user = "ec2-user"
    private_key = "${file("${path.module}/../../infra-3/id_rsa")}"
  }

  provisioner "remote-exec" {
    script = "${path.module}/provision-docker.sh"
  }
  */
}

# Allow public access to the front-end server
resource "aws_security_group_rule" "front_end" {
  type        = "ingress"
  from_port   = var.ingress_from_port
  to_port     = var.ingress_to_port
  protocol    = var.ingress_protocol
  cidr_blocks = [var.ingress_cidr] 

  security_group_id = "${aws_security_group.front_end_sg.id}"
}
### end of front-end
