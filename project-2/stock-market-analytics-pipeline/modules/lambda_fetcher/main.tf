resource "aws_iam_role" "lambda_exec" {
  name = "lambda_fetcher_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_lambda_function" "fetch_stock" {
  filename         = "lambda.zip"
  function_name    = "fetchStockData"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("lambda.zip")
  environment {
    variables = {
      STREAM_NAME = var.stream_name
    }
  }
}