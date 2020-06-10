data "archive_file" "lambda_zip" {
  type = "zip"
  source_file = "${path.module}/lambda/xpto.py"
  output_path = "${path.module}/lambda/xpto.py"
}

output "hash" {
  value = data.archive_file.lambda_zip.output_base64sha256
}

output "path" {
  value = data.archive_file.lambda_zip.output_path
}
