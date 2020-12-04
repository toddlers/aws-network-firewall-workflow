resource "aws_networkfirewall_rule_group" "allow-local" {
  capacity = 1000
  name     = "allow-local-ranges"
  type     = "STATELESS"
  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        stateless_rule {
          priority = 5
          rule_definition {
            actions = ["aws:pass"]
            match_attributes {
              source {
                address_definition = "10.0.0.0/8"
              }
              source {
                address_definition = "192.168.0.0/16"
              }
            }
          }
        }
      }
    }
  }
}

resource "aws_networkfirewall_rule_group" "deny-http-domains" {
  capacity = 100
  name     = "deny-http-domains"
  type     = "STATEFUL"
  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "DENYLIST"
        target_types         = ["HTTP_HOST"]
        targets              = var.http-domains-to-deny
      }
    }
  }

  tags = {
    "Name" = "deny-http-domains"
  }
}

resource "aws_networkfirewall_rule_group" "deny-https-domains" {
  capacity = 100
  name     = "deny-https-domains"
  type     = "STATEFUL"
  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "DENYLIST"
        target_types         = ["TLS_SNI"]
        targets              = var.https-domains-to-deny
      }
    }
  }

  tags = {
    "Name" = "deny-https-domains"
  }
}

resource "aws_networkfirewall_rule_group" "deny-http" {
  capacity = 100
  name     = "deny-http"
  type     = "STATEFUL"
  rule_group {
    rules_source {
      stateful_rule {
        action = "DROP"
        header {
          destination      = aws_subnet.application.cidr_block
          destination_port = 80
          direction        = "ANY"
          protocol         = "HTTP"
          source           = "0.0.0.0/0"
          source_port      = 80
        }
        rule_option {
          keyword = "sid:1"
        }
      }
    }
  }

  tags = {
    "Name" = "deny-http"
  }
}


resource "aws_networkfirewall_rule_group" "deny-ssh" {
  capacity = 100
  name     = "deny-ssh"
  type     = "STATEFUL"
  rule_group {
    rules_source {
      stateful_rule {
        action = "DROP"
        header {
          destination      = aws_subnet.application.cidr_block
          destination_port = 22
          direction        = "ANY"
          protocol         = "SSH"
          source           = "0.0.0.0/0"
          source_port      = "ANY"
        }
        rule_option {
          keyword = "sid:1"
        }
      }
    }
  }

  tags = {
    "Name" = "deny-ssh"
  }
}
