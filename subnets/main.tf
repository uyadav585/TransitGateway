resource "aws_subnet" "subnet" {
  count = length(var.vpc-id)
  
  vpc_id     = var.vpc-id[count.index]
  cidr_block = cidrsubnet(var.vpc_cidr_blocks[count.index], 8, count.index + 1)
  map_public_ip_on_launch = true

  tags = {
    Name = "vpc-${count.index + 1}-subnet"
  }
}