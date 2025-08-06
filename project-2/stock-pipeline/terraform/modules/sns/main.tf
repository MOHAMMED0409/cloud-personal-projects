resource "aws_sns_topic" "stock_alerts" {
  name = "stock-alerts-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.stock_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email  # e.g., yourname@example.com
}

output "sns_topic_arn" {
  value = aws_sns_topic.stock_alerts.arn
}
