resource "aws_security_group" "ingress" {
  #vpc_id      = "${local.vpc_id}"
  name        = "${var.prefix}-${var.ingress_sg-name}"
  description = "SSH ingress access"

  ingress {
    from_port = var.ingress_from_port
    to_port = var.ingress_to_port
    protocol = var.ingress_protocol
    cidr_blocks = ["${var.ingress_cidr_blocks}"]
  }

  tags = {
    Name = "${var.prefix}-${var.ingress_sg-name}"
    createdBy = "infra-${var.prefix}/news"
  }
}

output "ingress-sg-id" {
  value = aws_security_group.ingress.id
}