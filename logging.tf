resource "aws_cloudwatch_log_group" "firewall" {
  name = var.cloudwatch-log-group-name

  tags = {
    "Name" = "test-network-firewall"
  }
}
resource "aws_networkfirewall_logging_configuration" "firewall" {
  firewall_arn = aws_networkfirewall_firewall.example.arn
  logging_configuration {
    log_destination_config {
      log_destination = {
        logGroup = aws_cloudwatch_log_group.firewall.name
      }
      log_destination_type = "CloudWatchLogs"
      log_type             = "ALERT"
    }
  }
}