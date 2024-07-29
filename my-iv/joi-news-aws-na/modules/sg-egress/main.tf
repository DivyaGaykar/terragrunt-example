resource "aws_security_group" "egress" {
  #vpc_id      = "${local.vpc_id}"
  name        = "${var.prefix}-${var.egress_sg-name}"
  description = "SSH egress access"

  egress {
    from_port = var.egress_from_port
    to_port = var.egress_to_port
    protocol = var.egress_protocol
    cidr_blocks = ["${var.egress_cidr_blocks}"]
  }

  tags = {
    Name = "${var.prefix}-${var.egress_sg-name}"
    createdBy = "infra-${var.prefix}/news"
  }
}

output "egress-sg-id" {
  value = aws_security_group.egress.id
}
