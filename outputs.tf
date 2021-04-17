output "subnet_id" {
  value = aws_subnet.private_subnets[0].id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
