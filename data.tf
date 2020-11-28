data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc_endpoint" "firewall" {
  vpc_id = aws_vpc.default.id

  tags = {
    "AWSNetworkFirewallManaged" = "true"
    "Firewall"                  = aws_networkfirewall_firewall.example.arn
  }

  depends_on = [aws_networkfirewall_firewall.example]
}