data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/xpto.py"
  output_path = "${path.module}/lambda/xpto.zip"
}

# data "terraform_remote_state" "flamarion_lab" {
#   backend = "remote"
#   config = {
    
#     hostname     = "app.terraform.io"
#     organization = "FlamarionLab"
#     workspaces = {
#       name = "31633"
#     }
#   }
# }

# This is cool!

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

# output "flamarion_lab_org_output" {
#   value = data.terraform_remote_state.flamarion_lab.outputs.master
# }
