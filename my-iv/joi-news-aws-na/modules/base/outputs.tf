output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "pub_sub_id_a" {
  value = aws_subnet.public_subnet_a.id
}

output "pri_sub_id_b" {
  value = aws_subnet.private_subnet_b.id
}


