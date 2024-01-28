output "subnet-id" {
  value = [for subnet in aws_subnet.subnet : subnet.id]
}

output "current-subnet-id" {
  value = aws_subnet.subnet[*].id
}