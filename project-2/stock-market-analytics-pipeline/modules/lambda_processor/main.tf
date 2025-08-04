resource "aws_iam_role" "lambda_exec" {
  name = "lambda_processor_role"
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

resource "aws_lambda_event_source_mapping" "kinesis_event" {
  event_source_arn = var.kinesis_arn
  function_name    = aws_lambda_function.process_stock.arn
  starting_position = "LATEST"
}

resource "aws_lambda_function" "process_stock" {
  filename         = "lambda.zip"
  function_name    = "processStockData"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("lambda.zip")
  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
}