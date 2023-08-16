output "InstanceId" {
  value = aws_instance.ec2_instance.id
}

output "PublicIpAddress" {
  value = aws_instance.ec2_instance.public_ip
}