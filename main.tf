terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "FlamarionLab"

    workspaces {
      name = "tf-demo-2"
    }
  }
}

data "tfe_team" "C3PO" {
  name         = "Owners"
  organization = "FlamarionLab"
}

data "tfe_ssh_key" "team_key" {
  name         = "ssh-key-demo"
  organization = "FlamarionLab"
}

output "tfe_things" {
  value = [
    data.tfe_team.C3PO,
    data.tfe_ssh_key.team_key
  ]
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/xpto.py"
  output_path = "${path.module}/lambda/xpto.zip"
}

resource "null_resource" "test" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "ls -la *"
  }
}

output "hash" {
  value = data.archive_file.lambda_zip.output_base64sha256
}

output "path" {
  value = data.archive_file.lambda_zip.output_path
}
