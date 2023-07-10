variable "name" {
  description = "Name which will be applied to all related resources."
  type        = string
  default     = "file-transfer-function"
}

variable "default_sftp_secret_value" {
  description = "Placeholder value to put into secret in secrets manager"
  type        = map(any)
  default = {
    user     = "foo"
    password = "pass"
    key      = ""
  }
}

variable "source_s3_name" {
  description = "ARN of source S3 bucket"
  type        = string
  default = "lambda-file-transfer-puff"
}

variable "target_sftp_endpoint" {
  description = "Endpoint of target SFTP server."
  type        = string
  default = "value"
}

variable "file_handler_function" {
  description = "Body of python function which handles file transfer logic from s3 to sftp."
  type        = string
  default     = <<FUNC
def file_handler(s3_bucket, sftp_client, event, context):
  return
FUNC
}