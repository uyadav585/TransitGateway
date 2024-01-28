resource "aws_ec2_transit_gateway" "transit" {
  description = "transit for all ec2"
  tags = {
    Name = "transit-gateway"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc-attachment" {
  count = length(var.vpc_id)
  vpc_id = var.vpc_id[count.index]
  transit_gateway_id = aws_ec2_transit_gateway.transit.id
  subnet_ids = [ var.subnet_ids[count.index] ]
  tags = {
    Name = "transit attachment with vpc id-${var.vpc_id[count.index]}"
  }
  depends_on = [ aws_ec2_transit_gateway.transit ]
}

/* resource "aws_ec2_transit_gateway_connect" "attachment" {
  count = length(var.vpc_id)
  transport_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc-attachment[count.index].id
  transit_gateway_id      = aws_ec2_transit_gateway.transit.id
} */
