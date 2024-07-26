resource "aws_security_group" "ingress" {
  #vpc_id      = "${local.vpc_id}"
  name        = "${var.prefix}-${var.sg-name}"
  description = "SSH ingress access"

  ingress {
    from_port = var.from_port
    to_port = var.to_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP"
    createdBy = "infra-${var.prefix}/news"
  }
}

output "sg-id" {
  value = aws_security_group.ingress.id
}