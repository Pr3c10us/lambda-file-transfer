resource "aws_secretsmanager_secret" "sftp_creds" {
  name                    = var.name
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "sftp_creds_version" {
  secret_id     = aws_secretsmanager_secret.sftp_creds.id
  secret_string = jsonencode(var.default_sftp_secret_value)

  lifecycle {
    ignore_changes = [secret_string]
  }
}