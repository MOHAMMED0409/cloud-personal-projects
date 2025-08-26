resource "aws_lambda_function" "ingest" {
  function_name    = "stock_ingest_lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_ingest.lambda_handler"
  runtime          = "python3.9"

  filename         = "${path.module}/../lambda_functions/lambda_ingest.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda_functions/lambda_ingest.zip")

  environment {
    variables = {
      KINESIS_STREAM = aws_kinesis_stream.stock_stream.name
    }
  }
}


resource "aws_lambda_event_source_mapping" "kinesis_ingest" {
  event_source_arn  = aws_kinesis_stream.stock_stream.arn
  function_name     = aws_lambda_function.ingest.arn
  starting_position = "LATEST"
}
