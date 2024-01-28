resource "aws_route_table" "route-table" {
  count = length(var.vpc_id)
  vpc_id = var.vpc_id[count.index]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id[count.index]
  }
  
  /*dynamic "route" {
    for_each = { for idx, subnet_id in var.subnet_ids : idx => subnet_id if subnet_id != var.current_subnet-id }
    
    content {
      cidr_block = 
      transit_gateway_id = var.transit_gateway-id
    }
  }*/

  tags = {
    Name = "route-${count.index + 1}"
  }
}

resource "aws_route_table_association" "associate-subnet" {
  count = length(var.subnet_ids)
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.route-table[count.index].id
}
