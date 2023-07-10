output "lambda_arn" {
  description = "ARN of lambda function."
  value       = aws_lambda_function.lambda.arn
}

output "sftp_secrets_arn" {
  description = "ARN of secret in AWS Secrets Manager that keeps SFTP credentials. Actual values should be set manually."
  value       = aws_secretsmanager_secret.sftp_creds.arn
}

output "lambda_iam_role_arn" {
  description = "ARN of Lambda's execution role"
  value       = aws_iam_role.role.arn
}