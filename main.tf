# Example resource demonstrating valid Terraform

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo 'Hello from Terraform!'"
  }
}