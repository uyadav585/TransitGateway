output "gateway-id" {
  value = [for gateway in aws_internet_gateway.gateways : gateway.id]
}