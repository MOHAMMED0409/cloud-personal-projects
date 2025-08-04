resource "aws_sns_topic" "stock_alerts" {
  name = "stock-alerts"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.stock_alerts.arn
  protocol  = "email"
  endpoint  = "mohammedkhashif02@gmail.com"
}