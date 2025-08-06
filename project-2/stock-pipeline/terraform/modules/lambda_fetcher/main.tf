resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_fetcher_exec_role"

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

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "kinesis_put_policy" {
  name = "lambda_kinesis_put_policy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "kinesis:PutRecord",
          "kinesis:PutRecords"
        ],
        Resource = "*"
      }
    ]
  })
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function/fetch_stock.py"
  output_path = "${path.module}/lambda_function_payload.zip"
}

resource "aws_lambda_function" "fetch_stock_data" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "fetch_stock_data"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "fetch_stock.lambda_handler"
  runtime          = "python3.12"
  timeout          = 10

  environment {
    variables = {
      API_KEY      = var.alpha_vantage_api_key
      STOCKS       = join(",", var.stock_symbols)
      STREAM_NAME  = var.stream_name
    }
  }
}

variable "alpha_vantage_api_key" {}
variable "stock_symbols" {
  type = list(string)
}
variable "stream_name" {}
