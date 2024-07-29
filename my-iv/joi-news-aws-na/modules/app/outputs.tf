output "app_instance_private_ip" {
  value = aws_instance.front_end.private_ip
}