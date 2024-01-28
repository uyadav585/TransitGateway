

resource "aws_vpc" "test-vpc" {
  count = length(var.cidr_blocks)
  cidr_block = var.cidr_blocks[count.index]
  instance_tenancy = "default"
  enable_dns_hostnames = true
  
  
  tags = {
    Name = "test-vpc-${count.index + 1}"
  }
}