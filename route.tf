resource "aws_route_table" "application" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block      = "0.0.0.0/0"
    vpc_endpoint_id = data.aws_vpc_endpoint.firewall.id
  }
  tags = {
    Name = "app-protected-route-table"
  }
}


resource "aws_route_table_association" "application" {
  route_table_id = aws_route_table.application.id
  subnet_id      = aws_subnet.application.id
}

resource "aws_route_table" "firewall-route-table" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "firewall-route-table"
  }
}

resource "aws_route_table_association" "firewall-table-association" {
  route_table_id = aws_route_table.firewall-route-table.id
  subnet_id      = aws_subnet.firewall.id
}

resource "aws_route_table" "gateway" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block      = aws_subnet.application.cidr_block
    vpc_endpoint_id = data.aws_vpc_endpoint.firewall.id
  }
  tags = {
    Name = "igw-route-table"
  }
}
resource "aws_route_table_association" "gateway" {
  gateway_id     = aws_internet_gateway.igw.id
  route_table_id = aws_route_table.gateway.id
}
