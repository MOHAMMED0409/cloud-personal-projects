resource "aws_lambda_function" "alert" {
  function_name = "stock_alert"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_alert.lambda_handler"
  runtime       = "python3.9"

  filename         = "${path.module}/../lambda_functions/lambda_alert.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda_functions/lambda_alert.zip")

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.stock_alerts.arn
    }
  }
}

resource "aws_lambda_event_source_mapping" "kinesis_alert" {
  event_source_arn  = aws_kinesis_stream.stock_stream.arn
  function_name     = aws_lambda_function.alert.arn
  starting_position = "LATEST"
}
