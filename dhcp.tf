resource "aws_vpc_dhcp_options" "default" {
  domain_name         = var.dhcp_domain
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = "test-default-dhcp-options"
  }
}

resource "aws_vpc_dhcp_options_association" "default" {
  vpc_id          = aws_vpc.default.id
  dhcp_options_id = aws_vpc_dhcp_options.default.id
}