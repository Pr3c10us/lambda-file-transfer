locals {
  lambda_content = templatefile("${path.module}/templates/main.py.tftpl", {
    secret_name    = aws_secretsmanager_secret.sftp_creds.id
    s3_bucket_name = var.source_s3_name
    region         = data.aws_region.current.name
    sftp_endpoint  = var.target_sftp_endpoint
    file_handler   = var.file_handler_function
  })
}

resource "local_file" "lambda_body" {
  filename = "${path.module}/dependencies/main.py"
  content  = local.lambda_content
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = path.module
  output_path = "${path.module}/lambda/lambda.zip"
  depends_on  = [null_resource.install_dependencies]
}

resource "null_resource" "install_dependencies" {
  provisioner "local-exec" {
    environment = {
      RUNTIME       = "python3.9"
      FUNCTION_NAME = var.name
      path_cwd      = path.module
    }
    command = "bash ${path.module}/scripts/create_pkg.sh"
  }

  depends_on = [local_file.lambda_body]
}