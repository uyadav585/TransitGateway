resource "aws_internet_gateway" "gateways" {
  count = length(var.vpc_id)
  vpc_id = var.vpc_id[count.index]

  tags = {
    Name = "gateway-${count.index + 1}"
  }
}