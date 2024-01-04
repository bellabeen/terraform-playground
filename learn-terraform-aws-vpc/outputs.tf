# output "instance_id" {
#   description = "ID of the EC2 instance"
#   value       = aws_instance.app_server.id
# }

# output "instance_public_ip" {
#   description = "Public IP address of the EC2 instance"
#   value       = aws_instance.app_server.public_ip
# }

# output "cidr_block" {
#   description = "CIDR Block"
#   value = aws_vpc.main
# }

output "id" {
  description = "CIDR Block"
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  value = aws_subnet.subnet_private[*].id
}

output "private_subnet_cidr_blocks" {
  value = aws_subnet.subnet_private[*].cidr_block
}

output "private_subnet_availability_zones" {
  value = aws_subnet.subnet_private[*].availability_zone
}