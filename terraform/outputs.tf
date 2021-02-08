output "public_ip_of_server" {
  value = "Public IP of EC2 is ${aws_instance.kul.public_ip}"
}
output "instance_id" {
  value = aws_instance.kul.id
}
output "apache_url" {
  value = "http://${aws_instance.kul.public_dns}"
}