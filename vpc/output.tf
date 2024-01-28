output "vpc-id" {
  value = [for vpc in aws_vpc.test-vpc : vpc.id]
}

output "cidr_blocks" {
  value = var.cidr_blocks
}