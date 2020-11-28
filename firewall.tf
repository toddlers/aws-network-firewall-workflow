resource "aws_networkfirewall_firewall_policy" "test-firewall-policy" {
  name = "test-aws-network-firewall-policy"
  firewall_policy {
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:pass"]
    stateless_rule_group_reference {
      priority     = 20
      resource_arn = aws_networkfirewall_rule_group.allow-local.arn
    }
    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.deny-http.arn
    }
    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.deny-https-domains.arn
    }
    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.deny-ssh.arn
    }
  }
}
resource "aws_networkfirewall_firewall" "example" {
  firewall_policy_arn = aws_networkfirewall_firewall_policy.test-firewall-policy.arn
  name                = var.firewall-name
  vpc_id              = aws_vpc.default.id
  subnet_mapping {
    subnet_id = aws_subnet.firewall.id
  }
  tags = {
    Name = "aws-network-firewall"
  }
  depends_on = [aws_vpc.default]
}