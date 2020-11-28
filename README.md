# aws-network-firewall-workflow
aws network firewall workflow for testing

This sets up a playground for working with  `aws-network-firewall` for trying out various rules and configuration as it takes a solid good amoung of time to create firewall.

* Code creates a firewall and adds four stateful and one stateless rule with a firewall policy for starters and configures the logging.
  * Creates an instance with a public IP in a application subnet with a basic lamp setup installed via `userdata`. Instance has a securtit group attached with
  `ssh` and `http` port open to `0.0.0.0/0`.
  * I hooked(code not added for this) the `CloudWatch` Log group with a lambda for generating various alerts or and processing them offline for some internal purpose.


### NOTE:

* There is a bug in terraform aws provider[1] where certain params for `aws_networkfirewall_rule_group` are not configurable properly. That's why in the `aws_networkfirewall_rule_group` I created in the example here , has provided all the options , instead of providing `ANY` which are supported actually[2]

* AWS Network Firewall is  available in US East (N. Virginia), US West (Oregon), and Europe (Ireland) Regions.



[1]. https://github.com/hashicorp/terraform-provider-aws/issues/16470

[2]. https://docs.aws.amazon.com/network-firewall/latest/APIReference/API_Header.html#networkfirewall-Type-Header-Destination

[3]. https://aws.amazon.com/de/blogs/aws/aws-network-firewall-new-managed-firewall-service-in-vpc/

[4]. https://aws.amazon.com/blogs/aws/new-vpc-ingress-routing-simplifying-integration-of-third-party-appliances/


