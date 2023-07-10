resource "aws_lambda_function" "lambda" {
  function_name    = var.name
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda..output_base64sha256
  role             = aws_iam_role.role.arn
  handler          = "main.handler"
  runtime          = "python3.9"
}
