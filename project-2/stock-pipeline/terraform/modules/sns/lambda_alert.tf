resource "aws_iam_role" "lambda_exec" {
  name = "lambda-sns-exec"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "lambda_logs" {
  name       = "lambda-logs"
  roles      = [aws_iam_role.lambda_exec.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "stock_alert" {
  function_name = "stock-trend-alert"
  runtime       = "python3.12"
  handler       = "handler.lambda_handler"

  filename         = "${path.module}/../lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda_function.zip")

  role = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.stock_alerts.arn
      PRICE_THRESHOLD = "150.00"  # Example threshold
    }
  }
}

resource "aws_lambda_permission" "allow_invoke" {
  statement_id  = "AllowExecutionFromYou"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stock_alert.arn
  principal     = "*"
}
