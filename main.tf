data "archive_file" "lambda_zip" {
  type = "zip"
  source_file = "${path.module}/lambda/xpto.py"
  output_path = "${path.module}/lambda/xpto.zip"
}

data "terraform_remote_state" "flamarion_lab" {
  backend = "remote"
  #token = "PG7VuF5ybzObkQ.atlasv1.xaFseHG53Sv2vw8m9jrazg5NlQv5jsgkjgV8v7iQQDla3Oqh87AbsZHUsMt6zgEJwWE"
  config = {
    organization = "FlamarionLab"

    workspaces = {
      name = "31633"
    }
  }
}

resource "null_resource" "test" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "ls -l *"
  }
}

output "hash" {
  value = data.archive_file.lambda_zip.output_base64sha256
}

output "path" {
  value = data.archive_file.lambda_zip.output_path
}

output "flamarion_lab_org_output" {
  value = data.terraform_remote_state.flamarion_lab.outputs.master
}
